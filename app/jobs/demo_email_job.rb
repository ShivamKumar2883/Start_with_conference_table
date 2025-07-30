class DemoEmailJob < ApplicationJob
  queue_as :default

  def perform()
    DemoEmailMailer.user_count.deliver_now
  end
end
