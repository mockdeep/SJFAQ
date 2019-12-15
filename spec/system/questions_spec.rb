# frozen_string_literal: true

require "rails_helper"

RSpec.describe "questions", type: :system do
  it "allows us to create questions" do
    user = User.create!(user_params)
    sign_in_as(user)

    add_question("Is climate change real?")

    expect(page).to have_text("Is climate change real?")
  end
end
