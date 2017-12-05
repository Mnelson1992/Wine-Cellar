class ChangeColumn < ActiveRecord::Migration
  def change
    rename_column :bottles, :type, :grape
  end
end
