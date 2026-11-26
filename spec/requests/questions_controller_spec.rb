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
end
