module StardustRails
  module Reports
    module Helpers
      def dates_from_variables(variables, variable_name, default_dates = nil, no_default: false)
        lookup_value = fetch_lookup_value(variables, variable_name) #variables[variable_name].to_s.underscore.gsub(/([\s.'_,])\1+/, "_")

        if lookup_value.downcase == "custom"
          dates = [
            Date.parse(variables["#{variable_name}_custom_start_at".to_sym]),
            Date.parse(variables["#{variable_name}_custom_end_at".to_sym]),
          ]
        else
          dates = date_ranges.fetch(
            lookup_value,
            default_dates || month_to_date_default(no_default)
          )
        end

        if dates == [nil, nil]
          dates
        else
          [
            dates.first.beginning_of_day,
            dates.last.end_of_day,
          ]
        end
      end

      private

      EST_ZONE_NAME = "Eastern Time (US & Canada)"

      def fetch_lookup_value(variables, variable_name)
        lookup_value = variables[variable_name]
        if lookup_value.blank?
          default_filter = filters_with_defaults.find { |filter| filter.variable == variable_name }
          lookup_value = default_filter&.default_value
        end
        lookup_value.to_s.underscore.gsub(/([\s.'_,])\1+/, "_").gsub(" ", "_")
      end

      def filters_with_defaults
        @filters_with_defaults ||= filters.select do |filter|
          filter.default_value.present?
        end.map do |filter|
          filter.variable(filter.variable.to_s.underscore.to_sym)
          filter
        end
      end

      def month_to_date_default(no_default)
        if no_default
          [nil, nil]
        else
          [
            now.beginning_of_month,
            now.end_of_month,
          ]
        end
      end

      def now
        @now ||= DateTime.now.in_time_zone(EST_ZONE_NAME)
      end

      def one_year_ago
        now - 1.year
      end

      def beginning_of_month
        now.beginning_of_month
      end

      def date_ranges
        {
          "month_to_date" => [
            beginning_of_month,
            now,
          ],
          "quarter_to_date" => [
            now.beginning_of_quarter,
            now,
          ],
          "year_to_date" => [
            now.beginning_of_year,
            now,
          ],
          "last_year_month_to_date" => [
            one_year_ago.beginning_of_month,
            one_year_ago,
          ],
          "last_year_quarter_to_date" => [
            one_year_ago.beginning_of_quarter,
            one_year_ago,
          ],
          "last_year_year_to_date" => [
            one_year_ago.beginning_of_year,
            one_year_ago,
          ],
          "this_week" => [
            now.beginning_of_week,
            now,
          ],
          "last_week" => [
            now.last_week.beginning_of_week,
            now.last_week.end_of_week,
          ],
          "last_month" => [
            now.last_month.beginning_of_month,
            now.last_month.end_of_month,
          ],
          "last_quarter" => [
            now.last_quarter.beginning_of_quarter,
            now.last_quarter.end_of_quarter,
          ],
          "last_year" => [
            now.last_year.beginning_of_year,
            now.last_year.end_of_year,
          ],
        }
      end
    end
  end
end
