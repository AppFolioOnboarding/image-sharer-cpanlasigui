module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)
      if feedback.save
        render :created, json: { message: 'Created' }
      else
        head :unprocessable_entity
      end
    end

    def feedback_params
      params.require(:feedback).permit(:name, :comment)
    end
  end
end
