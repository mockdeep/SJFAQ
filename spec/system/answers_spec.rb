# frozen_string_literal: true

RSpec.describe "answers", :js do
  it "allows admins to create answers" do
    user = create_and_sign_in_admin
    create_question(user:, text: "Where is Spain?")

    expect(page).to have_link(t("add_answer"))
    add_answer("In Europe", question_text: "Where is Spain?")

    expect(page).to have_text("In Europe")
  end

  it "allows admins to update answers" do
    user = create_and_sign_in_admin
    create_question(user:, text: "Where is Spain?")
    add_answer("In Europe", question_text: "Where is Spain?")

    update_answer("Where is Spain?", text: "In Eurasia")

    expect(page).to have_text("In Eurasia")
  end

  it "does not allow non-admins to create answers" do
    user = create_and_sign_in_user
    create_question(user:, text: "What is electability?")

    expect(page).to have_no_link(t("add_answer"))
    expect(page).to have_text("What is electability?")
  end

  it "does not allow non-admins to update answers" do
    user = create_and_sign_in_user
    question = create_question(user:, text: "Where is Spain?")
    create_answer(question:, user:, text: "In Europe")

    expect(page).to have_text("In Europe")
    expect(page).to have_no_link(t("edit_answer"))
  end
end
