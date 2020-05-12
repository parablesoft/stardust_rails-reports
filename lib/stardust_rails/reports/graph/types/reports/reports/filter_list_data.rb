Stardust::GraphQL.define_types do
  object :filter_list_data do
    description "Data for a filter pick list"
    field :id, :id, null: false
    field :label, :string, null: false
  end


end


