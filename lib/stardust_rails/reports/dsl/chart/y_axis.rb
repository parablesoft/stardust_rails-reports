module StardustRails
  module Reports
    class Dsl
      class Chart
        class YAxis

          def initialize(field = nil)
            @field = field
          end

          def field(value = nil)
            if value.present?
              @field = value
            else
              @field
            end
          end

          def data_type(value = nil)
            if value.present?
              @data_type = value
            else
              @data_type
            end
          end

          def max(value = nil)
            if value.present?
              @max = value
            else
              @max
            end
          end
        end
      end
    end
  end
end
