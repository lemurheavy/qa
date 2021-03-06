class AnswersController < ApplicationController
  before_filter :require_login, only: [:create]

  def create
    @question = Question.find(params[:answer][:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end