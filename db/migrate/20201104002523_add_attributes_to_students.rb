class AddAttributesToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :string
    add_column :students, :email, :string
    add_column :students, :token, :string
    add_column :students, :refresh_token, :string
  end
end
