class SetDefaultValueForKmsSettingsValuesField < ActiveRecord::Migration[5.0]
  def change
    change_column_default :kms_settings, :values, {}
  end
end
