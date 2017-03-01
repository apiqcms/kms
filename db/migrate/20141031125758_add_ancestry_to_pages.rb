class AddAncestryToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :kms_pages, :ancestry, :string
    add_index :kms_pages, :ancestry
  end
end
