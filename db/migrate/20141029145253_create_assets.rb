class CreateAssets < ActiveRecord::Migration
  def change
    create_table :kms_assets do |t|
      t.string :file
      t.string :content_type

      t.timestamps null: false
    end
  end
end
