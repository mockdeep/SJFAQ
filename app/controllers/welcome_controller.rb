# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action(:authenticate_user)
  def index
    questions = Question.includes(:answer)

    render(Views::Welcome::Index.new(questions:))
  end
end
