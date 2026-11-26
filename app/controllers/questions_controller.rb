# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new
    render(Views::Questions::New.new)
  end

  def edit
    question = Question.find(params.expect(:id))

    render(Views::Questions::Edit.new(question:))
  end

  def create
    current_user.questions.create!(question_params)
    redirect_to(root_path)
  end

  def update
    question = Question.find(params.expect(:id))
    question.update!(question_params)
    redirect_to(root_path)
  end

  private

  def question_params
    params.expect(question: [:text])
  end
end
