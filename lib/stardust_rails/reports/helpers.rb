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
          dates.first.in_time_zone(EST_ZONE_NAME).beginning_of_day,
          dates.last.in_time_zone(EST_ZONE_NAME).end_of_day
        ]
      end

      private

      EST_ZONE_NAME = "Eastern Time (US & Canada)"


      def month_to_date_default
        [
          DateTime.now.beginning_of_month,
          DateTime.now.end_of_month
        ]
      end

      def date_ranges
        {
          "month_to_date" => [
            DateTime.now.beginning_of_month,
            DateTime.now
          ],
          "quarter_to_date" => [
            DateTime.now.beginning_of_quarter,
            DateTime.now
          ],
          "year_to_date" => [
            DateTime.now.beginning_of_year,
            DateTime.now
          ],
          "last_year_month_to_date" => [
            1.year.ago.beginning_of_month,
            1.year.ago
          ],
          "last_year_quarter_to_date" => [
            1.year.ago.beginning_of_quarter,
            1.year.ago
          ],
          "last_year_year_to_date" => [
            1.year.ago.beginning_of_year,
            1.year.ago
          ],
          "this_week" => [
            DateTime.now.beginning_of_week,
            DateTime.now
          ],
          "last_week" => [
            DateTime.now.last_week.beginning_of_week,
            DateTime.now.last_week.end_of_week
          ],
          "last_month" => [
            DateTime.now.last_month.beginning_of_month,
            DateTime.now.last_month.end_of_month
          ],
          "last_quarter" => [
            DateTime.now.last_quarter.beginning_of_quarter,
            DateTime.now.last_quarter.end_of_quarter
          ],
          "last_year" => [
            DateTime.now.last_year.beginning_of_year,
            DateTime.now.last_year.end_of_year
          ]
        }
      end
    end
  end
end
