Stardust::GraphQL.define_types do
  object :report_chart do
    description "Report information"
    field :type, :string, null: true
    field :description, :string, null: true
    field :x_axis, :report_chart_x_axis, null: true
    field :y_axis, :report_chart_y_axis, null: true
  end

  object :report_chart_x_axis do
    field :field, :string, null: true
    field :data_type, :string, null: true
  end

  object :report_chart_y_axis do
    field :field, :string, null: true
    field :data_type, :string, null: true
    field :max, :float, null: true
  end
end


