class AddLongWebsiteToExpert < ActiveRecord::Migration
  def change
    add_column :experts, :long_website, :string
  end
end
