Stardust::GraphQL.define_mutation :stardust_rails_reports_destroy do

  description "Destroys a report"

  argument :id, :id,
    loads: StardustRails::Reports::Report,
    as: :report,
    required: true


  field :result, :raw, null: true

  def resolve(report:)
    report.destroy
    { 
     result: {
        message: "Success"
     }
    }
  end


  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    StardustRails::Reports.configuration.manager_roles
  end

end
