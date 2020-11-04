class AddRoletoStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :role, :string, :default => "student"
  end
end
