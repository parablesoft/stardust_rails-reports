Stardust::GraphQL.define_query :stardust_rails_reports_list do
  description ""
  type [:report]
  null false

  argument :keyword,
    :string,
    required: false

  argument :group,
    :string,
    required: false

  argument :tags,
           :string,
           required: false

  def resolve(keyword: nil, group: nil, tags: nil)
    query = StardustRails::Reports::Report.available_reports(user: current_user, group: group, tags: tags)

    if keyword
      query = query
        .select { |r| r.configuration.include?(keyword) }
    end

    query
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
