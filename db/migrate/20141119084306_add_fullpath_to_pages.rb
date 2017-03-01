class AddFullpathToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :kms_pages, :fullpath, :string
  end
end
