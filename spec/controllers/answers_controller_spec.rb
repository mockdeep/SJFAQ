# frozen_string_literal: true

require "rails_helper"

RSpec.describe AnswersController do
  def sign_in
    user = User.create!(
      email: "demo@exampoo.com",
      password: "super-secure",
      password_confirmation: "super-secure",
      role: :admin,
    )
    session[:user_id] = user.id
    user
  end

  describe "#new" do
    it "renders a new form" do
      question = sign_in.questions.create!(text: "Why?")

      get(:new, params: { question_id: question.id })

      expect(response.body).to include(I18n.t("create_answer"))
    end
  end

  describe "#edit" do
    it "renders an edit form" do
      user = sign_in
      question = user.questions.create!(text: "Why?")
      answer = user.answers.create!(question:, text: "Because")

      get(:edit, params: { id: answer.id })

      expect(response.body).to include(I18n.t("update_answer"))
    end
  end
end
