module StardustRails
  module Reports
    class Dsl
      class Field
        class Footer


          def with_user(user)
            @user = user
            self
          end

          def with_variables(variables)
            @variables = variables
            self
          end


          def label(value=nil)
            if value.present?
              @label=value
            else
              @label
            end
          end


          private

          attr_reader :user,
            :variables

        end
      end
    end
  end
end
