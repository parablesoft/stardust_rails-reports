class StardustRails::Reports::Report < ActiveRecord::Base
  self.table_name = "stardust_rails_reports"

  def self.available_reports(user:, group: nil)
    scope = StardustRails::Reports::Report

    scope = group.nil? ? scope.all : scope.where(group: group)
    scope.select do |report|
      begin
        report.with_user(user)
        dsl = StardustRails::Reports::Dsl.new.with_user(user)
        dsl.instance_eval(report.configuration)

        if dsl.report.visible.is_a?(Proc)
          dsl.report.visible.call
        else
          dsl.report.visible
        end
      rescue => error
        puts error.message
        false
      end
    end
  end

  def self.load(id:, user:, variables: nil)
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

  def records(display: false)
    key = dsl.report.supplemental_data&.key
    data.map do |record|
      output = record.slice(*(display ? field_names_for_display : field_names))

      if key && supplemental_data
        match = supplemental_data.find { |sdr| sdr[key] == output[key] }
        output.merge!(match.reject { |k, v| k == key }) if match
      end
      output
    end
  end

  def header
    dsl.report.header ?
      dsl_report_header :
      name
  end

  def background_download
    dsl.background_download
  end

  def chart
    dsl.report.chart
  end

  def default_sort
    dsl.report.default_sort
  end

  def filters
    @filters ||= filters_with_list_data
  end

  def fields
    @fields ||= dsl.report.fields
  end

  def sql
    begin
      if dsl.report.sql
        dsl.report.sql.call
      else
        query_results&.to_sql&.strip
      end
    rescue
      puts "Cannot generate SQL"
      return ""
    end
  end

  def supplemental_data
    @supplemental_data ||= if dsl.report.supplemental_data.query
        instance_exec(ids, &dsl.report.supplemental_data.query)
      else
        nil
      end
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
        list_data: filter.list_data ? filter.list_data.call : nil,
      }
    end
  end

  def dsl_filters
    dsl.report.filters
  end

  def field_names
    @field_names ||= fields.map(&:field_names).flatten.uniq
  end

  def field_names_for_display
    @field_names_for_display ||= fields.reduce([]) do |accu, field|
      field_name = field.link_text_field || field.name
      accu << field_name
      accu
    end.flatten.uniq
  end

  def ids
    key = dsl.report.supplemental_data.key
    return nil unless key.present?
    @ids ||= data.map { |r| r[key] }
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

  def sql_results
    begin
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.exec_query(sql)
      end
    rescue ActiveRecord::StatementInvalid => e
      Rails.logger.debug e.message
      ActiveRecord::Base.connection.reconnect!
      return []
    end
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
