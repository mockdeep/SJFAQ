# frozen_string_literal: true

require "rails_helper"

RSpec.describe AnswersController do
  def create_answer(user)
    question = user.questions.create!(text: "Why?")
    user.answers.create!(question:, text: "Because")
  end

  describe "#new" do
    it "renders a new form" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      get(new_question_answer_path(question))

      expect(response.body).to include(I18n.t("create_answer"))
    end
  end

  describe "#edit" do
    it "renders an edit form" do
      admin = create(:user, role: :admin)
      answer = create_answer(admin)
      login_as(admin)

      get(edit_answer_path(answer))

      expect(response.body).to include(I18n.t("update_answer"))
    end
  end
end
