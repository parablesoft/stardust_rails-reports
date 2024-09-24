Stardust::GraphQL.define_types do
  object :report do
    description "Report information"
    field :id, :id, null: false
    field :name, :string, null: true
    field :group, :string, null: true
    field :filters, [:report_filter], null: false
    field :records, :raw, null: true
    field :fields, [:report_field], null: false
    field :header, :string, null: false
    field :configuration, :string, null: true
    field :default_sort, [:string], null: true
    field :sql, :string, null: false
    field :chart, :report_chart, null: true
    field :background_download, :boolean, null: false
    field :tags, [:string], null: true
  end

  input_object :report_update_attributes do
    argument :group, :string, required: false
    argument :name, :string, required: false
    argument :configuration, :string, required: false
    argument :tags, [:string], required: false
  end
end
