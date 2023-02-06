module StardustRails
  module Reports
    class Dsl
      class SupplementalData
        attr_reader :key

        def initialize(key)
          @key = key
        end

        def query(&block)
          if block_given?
            @query = block
          else
            @query
          end
        end
      end
    end
  end
end
