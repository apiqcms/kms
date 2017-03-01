class CreateTemplates < ActiveRecord::Migration[4.2]
  def change
    create_table :kms_templates do |t|
      t.string :name
      t.text :content, default: ""

      t.timestamps null: false
    end
  end
end
