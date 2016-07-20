class CreateKmsSettings < ActiveRecord::Migration
  def change
    create_table :kms_settings do |t|
      t.json :values

      t.timestamps null: false
    end
  end
end
