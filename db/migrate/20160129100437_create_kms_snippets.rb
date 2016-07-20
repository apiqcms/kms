class CreateKmsSnippets < ActiveRecord::Migration
  def change
    create_table :kms_snippets do |t|
      t.string :name
      t.string :slug
      t.text :content

      t.timestamps null: false
    end
  end
end
