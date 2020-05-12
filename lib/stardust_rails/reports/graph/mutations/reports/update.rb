Stardust::GraphQL.define_mutation :stardust_rails_reports_update do

  description "Updates a report"

  argument :id, :id,
    loads: StardustRails::Reports::Report,
    as: :report,
    required: true

  argument :attributes, :report_update_attributes, required: true

  field :report, :report, null: true
  field :error, :raw, null: true

  def resolve(report:,attributes:)
    report.update_attributes(attributes.to_h)
    { 
     report: report
    }
  end


  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && current_user.role == "sys_admin"
  end


end
