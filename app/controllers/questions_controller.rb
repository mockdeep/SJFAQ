class QuestionsController < ApplicationController
  def new
    
  end

  def create
    current_user.questions.create!(question_params)
    redirect_to(root_path)
  end
  
  private 
  def question_params
    params.require(:question).permit(:text)
  end


end