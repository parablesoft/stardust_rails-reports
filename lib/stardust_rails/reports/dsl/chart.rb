require_relative "chart/x_axis"
require_relative "chart/y_axis"

module StardustRails
  module Reports
    class Dsl
      class Chart

        def type(value = nil)
          if value.present?
            @type = value
          else
            @type
          end
        end

        def description(value = nil)
          if value.present?
            @description = value
          else
            @description
          end
        end

        def x_axis(field=nil,&block)
          if block_given?
            axis = StardustRails::Reports::Dsl::Chart::XAxis.new(field)
            axis.instance_eval(&block)
            @x_axis = axis
          else
            @x_axis
          end
        end


        def y_axis(field=nil,&block)
          if block_given?
            axis = StardustRails::Reports::Dsl::Chart::YAxis.new(field)
            axis.instance_eval(&block)
            @y_axis = axis
          else
            @y_axis
          end
        end

      end
    end
  end
end
