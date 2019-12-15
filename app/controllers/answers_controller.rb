# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    question = Question.find(params[:question_id])

    render(:new, locals: { question: question })
  end

  def create
    current_user.answers.create!(answer_params)
    redirect_to(root_path)
  end

  private

  def answer_params
    question_id = params.fetch(:question_id)
    params.require(:answer).permit(:text).merge(question_id: question_id)
  end
end
