Stardust::GraphQL.define_query :stardust_rails_reports_list do

  description ""
  type [:report]
  null false


  argument :keyword,
    :string,
    required: false

  def resolve(keyword: nil)
    unless keyword
      StardustRails::Reports::Report.available_reports(user: current_user)
    else
      StardustRails::Reports::Report.available_reports(user: current_user)
        .select {|r| r.configuration.include?(keyword)}
    end
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
