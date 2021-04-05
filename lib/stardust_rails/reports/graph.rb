module StardustRails
  module Reports
    class Graph

      class DuplicatedInclusionExclusionArgumentsPassed < StandardError;end

      def self.load_types(options={})
        load_items(
          item_type: :types, 
          options: options
        )
      end

      def self.load_queries(options={})
        load_items(
          item_type: :queries, 
          options: options
        )
      end

      def self.load_mutations(options={})
        load_items(
          item_type: :mutations, 
          options: options
        )
      end


      private

      DEFAULT_PATH = "graph"

      def self.load_items(item_type:,options:{})
        except = options.fetch(:except,nil)
        only = options.fetch(:only,nil)
        path_prefix = options.fetch(:path_prefix,nil)

        if except && only
          raise StardustRails::Reports::Graph::DuplicatedInclusionExclusionArgumentsPassed
        end


        path = "graph/#{item_type}/**/*.rb"
        path = "#{path_prefix}/#{path}" if path_prefix

        Dir[Rails.root.join(__dir__).join(path)].each do |file|
          if except
            load file unless file_match?(file: file, collection: except)
          elsif only
            load file if file_match?(file: file, collection: only)
          else
            load file
          end
        end
      end


      def self.file_match?(file:,collection:)
        collection.any? {|item| file.ends_with?("/#{item}.rb")}
      end
    end

  end
end
