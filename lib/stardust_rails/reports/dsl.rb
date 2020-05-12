require 'method_source'

class StardustRails::Reports::Dsl

  def with_user(user)
    @user = user
    self
  end

  def with_variables(variables)
    @variables = variables
    self
  end

  def report(&block)
    if block_given?
      @report = StardustRails::Reports::Dsl::Report.new
      @report.with_user(user) if user
      @report.with_variables(variables) if variables
      @report.instance_eval(&block)
    else
      @report
    end
  end


  private

  attr_reader :user,
    :variables
end


require_relative 'dsl/report'
