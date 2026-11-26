# frozen_string_literal: true

require "rails_helper"

RSpec.describe WelcomeController do
  def create_user(**params)
    User.create!(
      email: "demo@exampoo.com",
      password: "super-secure",
      password_confirmation: "super-secure",
      **params,
    )
  end

  def sign_in(**params)
    user = create_user(**params)
    session[:user_id] = user.id
    user
  end

  def create_answered_question(user)
    question = user.questions.create!(text: "Why?")
    user.answers.create!(question:, text: "<strong>Because</strong>")
    question
  end

  describe "#index" do
    it "renders questions" do
      create_answered_question(create_user)

      get(:index)

      expect(response.body).to include("Why?")
    end

    it "renders answers as rich text" do
      create_answered_question(create_user)

      get(:index)

      expect(response.body).to include("<strong>Because</strong>")
    end

    it "shows the log in link when logged out" do
      get(:index)

      expect(response.body).to include("Log In")
    end

    it "does not show admin links to non-admins" do
      create_answered_question(sign_in)

      get(:index)

      expect(response.body).not_to include(I18n.t("edit_answer"))
    end

    it "does not show the add answer link to non-admins" do
      sign_in.questions.create!(text: "Why?")

      get(:index)

      expect(response.body).not_to include(I18n.t("add_answer"))
    end

    it "shows the user's email when logged in" do
      sign_in

      get(:index)

      expect(response.body).to include("demo@exampoo.com")
    end

    it "shows a link to add a question to admins" do
      sign_in(role: :admin)

      get(:index)

      expect(response.body).to include(I18n.t("add_question"))
    end

    it "shows a link to edit questions to admins" do
      create_answered_question(sign_in(role: :admin))

      get(:index)

      expect(response.body).to include(I18n.t("edit_question"))
    end

    it "shows a link to edit answers to admins" do
      create_answered_question(sign_in(role: :admin))

      get(:index)

      expect(response.body).to include(I18n.t("edit_answer"))
    end

    it "shows a link to add an answer to admins" do
      sign_in(role: :admin).questions.create!(text: "Why?")

      get(:index)

      expect(response.body).to include(I18n.t("add_answer"))
    end
  end
end
