require "stardust_rails/reports/engine" 
require_relative "reports/helpers"
require_relative "reports/configuration"
require "stardust_rails/reports/dsl"
require_relative "reports/utils"


module StardustRails
  module Reports
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
