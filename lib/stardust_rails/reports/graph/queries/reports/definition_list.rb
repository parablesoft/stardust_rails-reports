Stardust::GraphQL.define_query :stardust_rails_reports_definition_list do

  description ""
  type [:report]
  null false


  def resolve
    StardustRails::Reports::Report.all
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
