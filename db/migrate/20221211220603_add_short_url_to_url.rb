class AddShortUrlToUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :urls, :short_url, :string
  end
end
