class Api::JobsController < ApplicationController

  def send_demo_email
    DemoEmailJob.perform_later
    render json: {  message: 'Demo email job enqueued' }
  end
end