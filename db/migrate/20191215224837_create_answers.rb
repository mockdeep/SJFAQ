# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :user, foreign_key: true, null: false
      t.references :question,
                   foreign_key: true,
                   null: false,
                   index: { unique: true }
      t.string :text, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
