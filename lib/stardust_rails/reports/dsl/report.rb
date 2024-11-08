require_relative "filter"
require_relative "field"
require_relative "chart"
require_relative "supplemental_data"
require_relative "data_dump"

module StardustRails
  module Reports
    class Dsl
      class Report
        include Helpers
        attr_reader :filters

        def data_dump(&block)
          if block_given?
            data_dump = StardustRails::Reports::Dsl::DataDump.new
            data_dump.instance_eval(&block)
            @data_dump = data_dump
          else
            @data_dump
          end
        end

        def with_user(user)
          @user = user
          self
        end

        def with_variables(variables)
          @variables = variables
          self
        end

        def initialize
          @filters = []
          @fields = []
        end

        def chart(&block)
          if block_given?
            chart = StardustRails::Reports::Dsl::Chart.new
            chart.instance_eval(&block)
            @chart = chart
          else
            @chart
          end
        end

        def default_sort(value = [], &block)
          if block_given?
            @default_sort = block
          elsif value.present?
            @default_sort = value
          else
            @default_sort
          end
        end

        def fields
          @fields.select do |field|
            return true if field.visible.nil?
            if field.visible.is_a?(Proc)
              field.visible.call
            else
              field.visible
            end
          end.map do |field|
            if field.show_totals.is_a?(Proc)
              value = field.show_totals.call
              field.show_totals(value)
            end
            field
          end
        end

        def filters
          @filters.select do |filter|
            filter.list_data.call if filter.list_data
            return true if filter.visible.nil?
            if filter.visible.is_a?(Proc)
              filter.visible.call
            else
              filter.visible
            end
          end
        end

        def field(name = nil, &block)
          if block_given?
            field = StardustRails::Reports::Dsl::Field.new(name)
              .with_variables(variables)
              .with_user(user)

            field.instance_eval(&block)
            @fields << field
            field
          end
        end

        def filter(&block)
          if block_given?
            filter = StardustRails::Reports::Dsl::Filter
              .new
              .with_user(user)
              .with_variables(variables)

            filter.instance_eval(&block)
            @filters << filter
            filter
          end
        end

        def query(&block)
          if block_given?
            @query = block
          else
            @query
          end
        end

        def supplemental_data(key = "", &block)
          key = "id" if key.blank?

          if block_given?
            data = StardustRails::Reports::Dsl::SupplementalData.new(key)
            data.instance_eval(&block)
            @supplemental_data = data
          else
            @supplemental_data
          end
        end

        def header(value = nil, &block)
          if block_given?
            @header = block
          elsif value.present?
            @header = value
          else
            @header
          end
        end

        def background_download(value = nil)
          if value.present?
            @background_download = value
          else
            @background_download = false
          end
        end

        def sql(&block)
          if block_given?
            @sql = block
          else
            @sql
          end
        end

        def visible(&block)
          if block_given?
            @visible = block
          elsif @visible
            @visible
          else
            true
          end
        end

        private

        attr_reader :user,
          :variables
      end
    end
  end
end
