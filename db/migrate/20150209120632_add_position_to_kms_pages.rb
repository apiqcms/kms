class AddPositionToKmsPages < ActiveRecord::Migration
  def change
    add_column :kms_pages, :position, :integer, default: 0, null: false
  end
end
