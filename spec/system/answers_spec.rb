# frozen_string_literal: true

require "rails_helper"

RSpec.describe "answers", type: :system do
  it "allows creating an answer" do
    create_and_sign_in_user

    add_question("Where is Spain?")
    add_answer("In Europe")

    expect(page).to have_text("Where is Spain?")
    expect(page).to have_text("In Europe")
  end
end
