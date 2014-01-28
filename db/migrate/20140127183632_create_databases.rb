class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.string :adapter
      t.string :host
      t.string :encoding
      t.string :database
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
