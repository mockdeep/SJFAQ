# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new; end

  def edit
    render(locals: { question: Question.find(params[:id]) })
  end

  def create
    current_user.questions.create!(question_params)
    redirect_to(root_path)
  end

  def update
    question = Question.find(params[:id])
    question.update!(question_params)
    redirect_to(root_path)
  end

  private

  def question_params
    params.require(:question).permit(:text)
  end
end
