class AddCoursesToPrizes < ActiveRecord::Migration[5.2]
  def change
    add_reference :prizes, :course, foreign_key: true
  end
end
