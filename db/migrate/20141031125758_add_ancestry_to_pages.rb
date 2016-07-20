class AddAncestryToPages < ActiveRecord::Migration
  def change
    add_column :kms_pages, :ancestry, :string
    add_index :kms_pages, :ancestry
  end
end
