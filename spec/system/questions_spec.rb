# frozen_string_literal: true

require "rails_helper"

RSpec.describe "questions", type: :system do
  user_params = {
    email: "demo@lmkw.io",
    password: "secret",
    password_confirmation: "secret",
  }

  def add_question(text)
    click_link("Add question")
    fill_in("Text", with: text)
    click_button("Create Question")
  end

  def sign_in_as(user)
    visit("/")

    click_link("Log In")

    expect(page).to have_text("Log in to YourAppNameHere")

    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    click_button("Log In")
  end

  it "allows us to create questions" do
    user = User.create!(user_params)
    sign_in_as(user)

    add_question("Is climate change real?")

    expect(page).to have_text("Is climate change real?")
  end
end
