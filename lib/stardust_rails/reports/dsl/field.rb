module StardustRails
  module Reports
    class Dsl
      class Field


        attr_reader :name

        def initialize(value)
          @name = value
        end

        def with_user(user)
          @user = user
          self
        end

        def with_variables(variables)
          @variables = variables
          self
        end

        def header(value=nil)
          if value.present?
            @header = value
          else
            @header
          end
        end

        def field_names
          output = [name]
          output << link_text_field unless link_text_field.nil?
          output
        end

        def type(value=nil)
          if value.present?
            @type=value
          else
            @type
          end
        end

        def link(value=nil)
          if value.present?
            @link = value
          else
            @link
          end
        end

        def link_text_field(value=nil)
          if value.present?
            @link_text_field = value
          else
            @link_text_field
          end
        end

        def target(value=nil)
          if value.present?
            @target = value
          else
            @target
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
