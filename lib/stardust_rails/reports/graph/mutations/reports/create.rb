Stardust::GraphQL.define_mutation :stardust_rails_reports_create do

  description "Creates a new report"


  field :report, :report, null: true
  field :error, :raw, null: true

  def resolve
    {
      report: StardustRails::Reports::Report.create
    }
  rescue => e
    {
      error: {
        message: e.message,
      }
    }
  end


  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && current_user.role == "sys_admin"
  end

end
