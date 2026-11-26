# frozen_string_literal: true

require "rails_helper"

RSpec.describe QuestionsController do
  describe "#new" do
    it "renders a new form" do
      login_as(create(:user, role: :admin))

      get(new_question_path)

      expect(response.body).to include(I18n.t("create_question"))
    end
  end

  describe "#edit" do
    it "renders an edit form" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      get(edit_question_path(question))

      expect(response.body).to include(I18n.t("update_question"))
    end
  end

  describe "#create" do
    it "creates a question for the current user" do
      admin = create(:user, role: :admin)
      login_as(admin)

      post(questions_path, params: { question: { text: "Why?" } })

      expect(admin.questions.sole.text).to eq("Why?")
    end

    it "redirects to the root path" do
      login_as(create(:user, role: :admin))

      post(questions_path, params: { question: { text: "Why?" } })

      expect(response).to redirect_to(root_path)
    end
  end

  describe "#update" do
    def update_params = { question: { text: "How?" } }

    it "updates the question" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      expect { patch(question_path(question), params: update_params) }
        .to change_record(question, :text).from("Why?").to("How?")
    end

    it "redirects to the root path" do
      admin = create(:user, role: :admin)
      question = admin.questions.create!(text: "Why?")
      login_as(admin)

      patch(question_path(question), params: { question: { text: "How?" } })

      expect(response).to redirect_to(root_path)
    end
  end
end
