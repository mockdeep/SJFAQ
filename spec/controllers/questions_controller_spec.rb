# frozen_string_literal: true

require "rails_helper"

RSpec.describe QuestionsController do
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
      sign_in

      get(:new)

      expect(response.body).to include(I18n.t("create_question"))
    end
  end

  describe "#edit" do
    it "renders an edit form" do
      question = sign_in.questions.create!(text: "Why?")

      get(:edit, params: { id: question.id })

      expect(response.body).to include(I18n.t("update_question"))
    end
  end
end
