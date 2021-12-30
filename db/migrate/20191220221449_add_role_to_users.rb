# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      create_enum :role_type, ["viewer", "admin"]
      change_table :users do |t|
        t.enum :role, enum_type: "role_type", default: "viewer", null: false
      end
    end
  end
end
