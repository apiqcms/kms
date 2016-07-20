class AddHiddenToPage < ActiveRecord::Migration
  def change
    add_column :kms_pages, :hidden, :boolean, default: false
  end
end
