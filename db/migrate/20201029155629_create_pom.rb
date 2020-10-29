# frozen_string_literal: true

class CreatePom < ActiveRecord::Migration[5.2]
  def change
    create_table :poms do |t|
      t.string :name
      t.string :description
      t.string :duration
      t.string :link
    end
  end
end
