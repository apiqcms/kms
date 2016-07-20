class AddTemplateIdToPages < ActiveRecord::Migration
  def change
    add_column :kms_pages, :template_id, :integer
    add_foreign_key :kms_pages, :kms_templates if respond_to?(:add_foreign_key)
  end
end
