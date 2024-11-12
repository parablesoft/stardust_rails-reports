module StardustRails
  module Reports
    class Dsl
      class DataDump
        def to(value = nil, &block)
          if block_given?
            @to = block
          elsif value.present?
            @to = value
          else
            @to
          end
        end

        def schedule_for(value = nil, &block)
          if block_given?
            @schedule_for = block
          elsif value.present?
            @schedule_for = value
          else
            @schedule_for
          end
        end

        def schedule_on(value = nil, &block)
          if block_given?
            @schedule_on = block
          elsif value.present?
            @schedule_on = value
          else
            @schedule_on
          end
        end
      end
    end
  end
end
