require "rails_helper"


RSpec.describe "questions", type: :system do

  user_params = {
    email: "demo@lmkw.io",
    password: "secret",
    password_confirmation: "secret",
  }

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
    click_link("Add question")
    fill_in("Text", with: "Is climate change real?")
    click_button("Create Question")
    expect(page).to have_text("Is climate change real?")
  end    
end