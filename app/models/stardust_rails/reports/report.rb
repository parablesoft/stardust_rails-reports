class StardustRails::Reports::Report < ActiveRecord::Base

  self.table_name = "stardust_rails_reports"

  def self.available_reports(user:)
    StardustRails::Reports::Report.all.select do |report|
      begin
        report.with_user(user)
        dsl = StardustRails::Reports::Dsl.new.with_user(user)
        dsl.instance_eval(report.configuration)
        dsl.report.visible
      rescue => error
        puts error.message
        false
      end
    end
  end

  def self.load(id:, user:,variables: nil)
    report = StardustRails::Reports::Report.find(id).with_user(user)
    report.with_variables(variables || {}) 
    report
  end

  def with_variables(variables)
    @variables = variables
    self
  end

  def with_user(user)
    @user = user
    self
  end

  def records
    data.map do |record|
      record.slice(*field_names)
    end
  end

  def header
    dsl.report.header ? 
      dsl_report_header :
      name
  end

  def filters
    @filters ||= filters_with_list_data
  end

  def fields
    @fields ||= dsl.report.fields
  end

  private

  attr_reader :user,
    :variables

  def dsl_report_header
    dsl.report.header.is_a?(String) ? 
      dsl.report.header :
      dsl.report.header.call

  end

  def filters_with_list_data
    dsl_filters.map do |filter|
      {
        label: filter.label,
        component: filter.component,
        variable: filter.variable,
        list_data: filter.list_data ? filter.list_data.call : nil
      }
    end
  end

  def dsl_filters
    dsl.report.filters
  end

  def field_names
    @field_names ||= fields.map &:name
  end

  def data
    query ? query_results : sql_results
  end

  def query
    dsl.report.query
  end

  def query_results
    query.call
  end

  def sql
    dsl.report.sql.call
  end

  def sql_results
    ActiveRecord::Base.connection.exec_query(sql)
  end

  def dsl
    @dsl ||= load_dsl
  end

  def load_dsl
    output = StardustRails::Reports::Dsl.new
      .with_user(user)
    output.with_variables(variables) if variables
    output.instance_eval(configuration)
    output
  end


end

