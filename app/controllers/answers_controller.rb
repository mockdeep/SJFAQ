# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    question = Question.find(params.expect(:question_id))

    render(Views::Answers::New.new(question:))
  end

  def edit
    answer = Answer.find(params.expect(:id))

    render(Views::Answers::Edit.new(answer:))
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
