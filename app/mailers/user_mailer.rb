class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def notification_email(follower, new_activity)
    @follower = follower
    @new_activity = new_activity
    @url  = 'http://pixtr.com/login'
    mail(to: @follower.email, subject: 'Welcome to Pixtr')
  end
end
