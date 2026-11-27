# frozen_string_literal: true

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

  describe "#create" do
    def answer_params = { answer: { text: "Because" } }

    it "creates an answer for the question" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      post(question_answers_path(question), params: answer_params)

      expect(question.reload.answer.text.to_plain_text).to eq("Because")
    end

    it "creates the answer for the current user" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      post(question_answers_path(question), params: answer_params)

      expect(question.reload.answer.user).to eq(admin)
    end

    it "redirects to the root path" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      post(question_answers_path(question), params: answer_params)

      expect(response).to redirect_to(root_path)
    end
  end

  describe "#update" do
    it "updates the answer" do
      admin = create(:user, role: :admin)
      answer = create_answer(admin)
      login_as(admin)

      patch(answer_path(answer), params: { answer: { text: "Just because" } })

      expect(answer.reload.text.to_plain_text).to eq("Just because")
    end

    it "redirects to the root path" do
      admin = create(:user, role: :admin)
      answer = create_answer(admin)
      login_as(admin)

      patch(answer_path(answer), params: { answer: { text: "Just because" } })

      expect(response).to redirect_to(root_path)
    end
  end
end
