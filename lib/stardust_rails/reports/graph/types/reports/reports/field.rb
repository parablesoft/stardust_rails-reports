Stardust::GraphQL.define_types do
  object :report_field do
    description "Report information"
    field :header, :string, null: false
    field :name, :string, null: false
    field :type, :string, null: false
    field :link, :string, null: true
  end


end


