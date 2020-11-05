class AddRoletoTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :role, :string, :default => "teacher"
  end
end
