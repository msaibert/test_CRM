class AddConfigToDatabase < ActiveRecord::Migration
  def change
    add_column :databases, :config, :text
  end
end
