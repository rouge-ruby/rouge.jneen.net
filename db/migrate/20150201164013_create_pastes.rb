class CreatePastes < ActiveRecord::Migration
  def change
    create_table :pastes do |t|
      t.string :language
      t.string :source
    end
  end
end
