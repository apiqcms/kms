class CreatePages < ActiveRecord::Migration
  def change
    create_table :kms_pages do |t|
      t.string :title
      t.string :slug
      t.text :content, default: ""
      t.boolean :published

      t.timestamps null: false
    end
  end
end
