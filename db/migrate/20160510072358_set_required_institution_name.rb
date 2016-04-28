class SetRequiredInstitutionName < ActiveRecord::Migration
  def change
    change_column :institutions, :name, :string, null: false
  end
end
