module StardustRails
  module Reports
    class Dsl
      class Filter


        def with_user(user)
          @user = user
          self
        end

        def with_variables(variables)
          @variables = variables
          self
        end

        def variable(value=nil)
          if value.present?
            @variable = value
          else
            @variable
          end
        end

        def label(value=nil)
          if value.present?
            @label=value
          else
            @label
          end
        end

        def component(value=nil)
          if value.present?
            @component = value
          else
            @component
          end
        end

        def list_data(&block)
          if block_given?
            @list_data = block
          else
            @list_data
          end
        end


        def visible(proc = nil, &block)
          if block_given?
            @visible = block
          elsif proc.is_a?(Proc)
            @visible = proc
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
