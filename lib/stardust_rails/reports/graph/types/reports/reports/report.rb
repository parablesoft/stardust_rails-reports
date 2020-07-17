Stardust::GraphQL.define_types do
  object :report do
    description "Report information"
    field :id, :id, null: false
    field :name, :string, null: true
    field :filters, [:report_filter], null: false
    field :records, :raw, null: true
    field :fields, [:report_field], null: false
    field :header, :string, null: false
    field :configuration, :string, null: true
    field :default_sort, [:string], null: true
  end

  input_object :report_update_attributes do
    argument :name, :string, required: true
    argument :configuration, :string, required: true
  end

end
