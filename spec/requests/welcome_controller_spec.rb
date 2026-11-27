# frozen_string_literal: true

RSpec.describe WelcomeController do
  def sign_in(**params)
    user = create(:user, **params)
    login_as(user)
    user
  end

  def create_answered_question(user)
    question = user.questions.create!(text: "Why?")
    user.answers.create!(question:, text: "<strong>Because</strong>")
    question
  end

  describe "#index" do
    it "renders questions" do
      create_answered_question(default_user)

      get(root_path)

      expect(response.body).to include("Why?")
    end

    it "renders answers as rich text" do
      create_answered_question(default_user)

      get(root_path)

      expect(response.body).to include("<strong>Because</strong>")
    end

    it "shows the log in link when logged out" do
      get(root_path)

      expect(response.body).to include("Log In")
    end

    it "does not show admin links to non-admins" do
      create_answered_question(sign_in)

      get(root_path)

      expect(response.body).not_to include(I18n.t("edit_answer"))
    end

    it "does not show the add answer link to non-admins" do
      sign_in.questions.create!(text: "Why?")

      get(root_path)

      expect(response.body).not_to include(I18n.t("add_answer"))
    end

    it "shows the user's email when logged in" do
      user = sign_in

      get(root_path)

      expect(response.body).to include(user.email)
    end

    it "shows a link to add a question to admins" do
      sign_in(role: :admin)

      get(root_path)

      expect(response.body).to include(I18n.t("add_question"))
    end

    it "shows a link to edit questions to admins" do
      create_answered_question(sign_in(role: :admin))

      get(root_path)

      expect(response.body).to include(I18n.t("edit_question"))
    end

    it "shows a link to edit answers to admins" do
      create_answered_question(sign_in(role: :admin))

      get(root_path)

      expect(response.body).to include(I18n.t("edit_answer"))
    end

    it "shows a link to add an answer to admins" do
      sign_in(role: :admin).questions.create!(text: "Why?")

      get(root_path)

      expect(response.body).to include(I18n.t("add_answer"))
    end
  end
end
