class AddFullpathToPages < ActiveRecord::Migration
  def change
    add_column :kms_pages, :fullpath, :string
  end
end
