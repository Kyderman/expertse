class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.string :firstname
      t.string :surname
      t.string :website

      t.timestamps
    end
  end
end
