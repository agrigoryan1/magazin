class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :comment
      t.string :name
      t.string :content_type
      t.binary :data, limit: 1.megabyte

      t.timestamps null: false
    end
  end
end
