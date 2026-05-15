# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    question = Question.find(params.expect(:question_id))

    render(:new, locals: { question: question })
  end

  def edit
    render(locals: { answer: Answer.find(params.expect(:id)) })
  end

  def create
    create_params = answer_params.merge(question_id: params[:question_id])
    current_user.answers.create!(create_params)
    redirect_to(root_path)
  end

  def update
    answer = Answer.find(params.expect(:id))
    answer.update!(answer_params)
    redirect_to(root_path)
  end

  private

  def answer_params
    params.expect(answer: [:text])
  end
end
