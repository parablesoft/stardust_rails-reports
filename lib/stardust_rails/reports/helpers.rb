module StardustRails
  module Reports
    module Helpers
      def dates_from_variables(variables,variable_name,default_dates=nil)
        lookup_value = variables[variable_name].to_s.underscore.gsub(/([\s.'_,])\1+/,"_")

        if lookup_value.downcase == "custom"
          dates = [
            Date.parse(variables["#{variable_name}_custom_start_at".to_sym]),
            Date.parse(variables["#{variable_name}_custom_end_at".to_sym])
          ]
        else
          dates = date_ranges.fetch(
            lookup_value,
            default_dates||month_to_date_default
          )

        end

        [
          dates.first.beginning_of_day,
          dates.last.end_of_day
        ]
      end

      private

      EST_ZONE_NAME = "Eastern Time (US & Canada)"


      def month_to_date_default
        [
          now.beginning_of_month,
          now.end_of_month
        ]
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
            now
          ],
          "quarter_to_date" => [
            now.beginning_of_quarter,
            now
          ],
          "year_to_date" => [
            now.beginning_of_year,
            now
          ],
          "last_year_month_to_date" => [
            one_year_ago.beginning_of_month,
            one_year_ago
          ],
          "last_year_quarter_to_date" => [
            one_year_ago.beginning_of_quarter,
            one_year_ago
          ],
          "last_year_year_to_date" => [
            one_year_ago.beginning_of_year,
            one_year_ago
          ],
          "this_week" => [
            now.beginning_of_week,
            now
          ],
          "last_week" => [
            now.last_week.beginning_of_week,
            now.last_week.end_of_week
          ],
          "last_month" => [
            now.last_month.beginning_of_month,
            now.last_month.end_of_month
          ],
          "last_quarter" => [
            now.last_quarter.beginning_of_quarter,
            now.last_quarter.end_of_quarter
          ],
          "last_year" => [
            now.last_year.beginning_of_year,
            now.last_year.end_of_year
          ]
        }
      end
    end
  end
end
