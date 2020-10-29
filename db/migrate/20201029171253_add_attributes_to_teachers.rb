class AddAttributesToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :email, :string
    add_column :teachers, :uid, :string
    add_index :teachers, :email, unique: true
  end
end
