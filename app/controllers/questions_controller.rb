# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new; end

  def edit
    render(locals: { question: Question.find(params.expect(:id)) })
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
