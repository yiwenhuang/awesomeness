class CreateCategories < ActiveRecord::Migration[5.1]
  def up
    create_table :categories do |t|
      t.string :name
      t.string :repo_url
      t.integer :technology_id

      t.timestamps
    end
    change_column :categories, :id, :integer, first: true, auto_increment: true
  end

  def down
    drop_table :categories
  end
end
