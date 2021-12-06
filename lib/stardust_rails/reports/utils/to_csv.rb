require "csv"

class StardustRails::Reports::Utils::ToCsv

  def initialize(report_id,user,raw_filters)
    @report_id = report_id
    @user = user
    @raw_filters = raw_filters
  end

  def call
    output = ""
    output << CSV.generate_line(headers)
    rows.each {|row| output << CSV.generate_line(row)}
    output
  end

  private

  def rows
    report.records(display: true).map &:values
  end

  def headers
    report.fields.map {|field| field.name.humanize.titleize}
  end


  def sanitized_filters
    return nil unless raw_filters
    hashed_filters.deep_transform_keys! { |key| key.underscore.to_sym }
  end


  def hashed_filters
    parsed_filters.to_h
  end

  def parsed_filters
    JSON.parse(raw_filters)
  end

  def report
    @report ||= StardustRails::Reports::Report.load(
      id: report_id, 
      user: user,
      variables: sanitized_filters
    )
  end

  attr_reader :report_id,
    :user,
    :raw_filters
end
