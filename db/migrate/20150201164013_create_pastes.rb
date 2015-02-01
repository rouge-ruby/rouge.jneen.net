class CreatePastes < ActiveRecord::Migration
  def change
    create_table :pastes do |t|
      t.timestamps null: false

      t.string :language
      t.text :source
    end
  end
end
