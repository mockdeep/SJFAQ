# frozen_string_literal: true

class RemoveTextFromAnswers < ActiveRecord::Migration[6.0]
  def up
    safety_assured { remove_column :answers, :text }
  end

  def down
    add_column :answers, :text, :string
    add_index :answers, :text, unique: true
  end
end
