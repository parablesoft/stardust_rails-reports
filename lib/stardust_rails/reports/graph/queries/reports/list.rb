Stardust::GraphQL.define_query :stardust_rails_reports_list do

  description ""
  type [:report]
  null false


  def resolve
    StardustRails::Reports::Report.available_reports(user: current_user)
  end

  private

  def current_user
    context[:current_user]
  end

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present?
  end
end
