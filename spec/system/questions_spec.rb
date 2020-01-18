# frozen_string_literal: true

require "rails_helper"

RSpec.describe "questions", type: :system do
  it "allows admins to create questions" do
    create_and_sign_in_admin

    expect(page).to have_link(t("add_question"))
    add_question("Is climate change real?")

    expect(page).to have_text("Is climate change real?")
  end

  it "allows admins to edit questions" do
    user = create_and_sign_in_admin
    create_question(user: user, text: "Where is Spain?")

    update_question("Where is Spain?", text: "Where is Portugal?")

    expect(page).to have_text("Where is Portugal?")
  end

  it "does not allow non-admins to create questions" do
    create_and_sign_in_user

    expect(page).to have_no_link(t("add_question"))
  end

  it "does not allow non-admins to edit questions" do
    user = create_and_sign_in_user
    create_question(user: user, text: "Where is Spain?")

    expect(page).to have_text("Where is Spain?")
    expect(page).to have_no_link(t("edit_question"))
  end
end
