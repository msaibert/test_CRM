class CreateSeletors < ActiveRecord::Migration
  def change
    create_table :seletors do |t|
      t.text :codigo
      t.string :titulo

      t.timestamps
    end
  end
end
