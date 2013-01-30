class CreateSettings < ActiveRecord::Migration
  def change
    create_table :mournful_settings_settings do |t|
      t.string :name
      t.string :value_type
      t.string :value
      t.string :description
      t.boolean :encrypted
      t.timestamps
    end
  end
end
