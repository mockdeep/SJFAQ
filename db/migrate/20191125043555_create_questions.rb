# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :text, null: false, index: { unique: true }
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
