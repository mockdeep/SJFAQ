# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action(:authenticate_user)
  def index
    render(:index, locals: { questions: Question.all })
  end
end
