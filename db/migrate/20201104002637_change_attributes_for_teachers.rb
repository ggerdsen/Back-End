class ChangeAttributesForTeachers < ActiveRecord::Migration[5.2]
  def change
    remove_column :teachers, :name
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
    add_column :teachers, :provider, :string
    add_column :teachers, :uid, :string
    add_column :teachers, :email, :string
    add_column :teachers, :token, :string
    add_column :teachers, :refresh_token, :string
    add_column :teachers, :school_name, :string
    add_column :teachers, :school_district, :string
  end
end
