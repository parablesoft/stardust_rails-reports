class AddGroupToReport < ActiveRecord::Migration[5.0]
  def change
    if table_exists?(:stardust_rails_reports) 
      add_column :stardust_rails_reports, :group, :string, null: true
    end
  end
end
