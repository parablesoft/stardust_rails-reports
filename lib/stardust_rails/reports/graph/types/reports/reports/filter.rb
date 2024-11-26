Stardust::GraphQL.define_types do
  object :report_filter do
    description "Report information"
    field :label, :string, null: false
    field :component, :string, null: false
    field :variable, :string, null: false
    field :list_data, [:filter_list_data], null: true
    field :default_value, :string, null: true
  end

  input_object :report_filter_attributes do
    argument :name, :string, required: false
    argument :value, :string, required: false
  end
end
