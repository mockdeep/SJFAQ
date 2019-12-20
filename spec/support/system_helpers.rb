# frozen_string_literal: true

module SystemHelpers
  def t(key)
    I18n.t(key)
  end

  def user_params
    {
      email: "demo@lmkw.io",
      password: "secret",
      password_confirmation: "secret",
    }
  end

  def create_question(params)
    Question.create!(params)

    visit(current_path)
  end

  def create_and_sign_in_admin
    user = User.create!(user_params.merge(role: :admin))
    sign_in_as(user)
    user
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
    click_link(t("add_question"))
    fill_in("Text", with: text)
    click_button(t("create_question"))
  end

  def add_answer(text, question_text:)
    expect(page).to have_text(question_text)
    click_link(t("add_answer"))
    fill_in("Text", with: text)
    click_button(t("create_answer"))
  end
end
