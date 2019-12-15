# frozen_string_literal: true

module SystemHelpers
  def user_params
    {
      email: "demo@lmkw.io",
      password: "secret",
      password_confirmation: "secret",
    }
  end

  def create_and_sign_in_user
    user = User.create!(user_params)
    sign_in_as(user)
    user
  end

  def sign_in_as(user)
    visit("/")

    click_link("Log In")

    expect(page).to have_text("Log in to YourAppNameHere")

    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    click_button("Log In")
  end

  def add_question(text)
    click_link("Add question")
    fill_in("Text", with: text)
    click_button("Create Question")
  end

  def add_answer(text)
    click_link("Add answer")
    fill_in("Text", with: text)
    click_button("Create Answer")
  end
end
