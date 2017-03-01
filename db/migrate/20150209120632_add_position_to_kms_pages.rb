class AddPositionToKmsPages < ActiveRecord::Migration[4.2]
  def change
    add_column :kms_pages, :position, :integer, default: 0, null: false
  end
end
