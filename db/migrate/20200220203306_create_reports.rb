class CreateReports < ActiveRecord::Migration[5.2]
  def change
    unless table_exists?(:stardust_rails_reports) 
      create_table :stardust_rails_reports do |t|
        t.string :name
        t.text :configuration
        t.timestamps
      end
    end
  end
end
