class AddClickedToUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :urls, :clicked, :integer, :default => 0
  end
end
