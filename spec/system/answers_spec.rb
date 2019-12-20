# frozen_string_literal: true

require "rails_helper"

RSpec.describe "answers", type: :system do
  it "allows admins to create answers" do
    user = create_and_sign_in_admin
    create_question(user: user, text: "Where is Spain?")

    expect(page).to have_link(I18n.t("add_answer"))
    add_answer("In Europe", question_text: "Where is Spain?")

    expect(page).to have_text("In Europe")
  end

  it "does not allow non-admins to create answers" do
    user = create_and_sign_in_user
    create_question(user: user, text: "What is electability?")

    expect(page).to have_no_link(I18n.t("add_answer"))
    expect(page).to have_text("What is electability?")
  end
end
