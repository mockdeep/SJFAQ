# frozen_string_literal: true

require "rails_helper"

RSpec.describe "questions", type: :system do
  it "allows admins to create questions" do
    create_and_sign_in_admin

    expect(page).to have_link(t("add_question"))
    add_question("Is climate change real?")

    expect(page).to have_text("Is climate change real?")
  end

  it "does not allow non-admins to create questions" do
    create_and_sign_in_user

    expect(page).to have_no_link(t("add_question"))
  end
end
