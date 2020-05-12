Stardust::GraphQL.define_query :stardust_rails_reports_report do

  description ""
  type :report
  null false

  argument :id, :id, 
    required: true


  argument :variables, 
    [:report_filter_attributes],
    required: false



  def resolve(id:,variables:)
    @variables = variables
    StardustRails::Reports::Report.load(id: id, user: current_user,variables: mapped_variables)
  end

  private

  attr_reader :variables

  def mapped_variables
    variables.reduce({}) do |accu,variable|
      accu[variable.name.underscore.to_sym] = variable.value
      accu
    end
  end


  def current_user
    context[:current_user]
  end

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present?
  end
end
