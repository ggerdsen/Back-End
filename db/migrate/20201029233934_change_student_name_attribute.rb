class ChangeStudentNameAttribute < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :name
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
  end
end
