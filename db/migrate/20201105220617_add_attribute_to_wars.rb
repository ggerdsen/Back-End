class AddAttributeToWars < ActiveRecord::Migration[5.2]
  def change
    add_column :wars, :opponent_course_name, :string
  end
end
