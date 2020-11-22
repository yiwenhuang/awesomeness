class CreateTechnologies < ActiveRecord::Migration[5.1]
  def up
    create_table :technologies do |t|
      t.string :name
      t.string :repo_url, unique: true
      t.integer :star_count
      t.integer :fork_count
      t.datetime :last_commit_at

      t.timestamps
    end
    change_column :technologies, :id, :integer, first: true, auto_increment: true
  end

  def down
    drop_table :technologies
  end
end
