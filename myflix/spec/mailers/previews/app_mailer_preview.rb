# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class AppMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/app_mailer/password_reset
  def password_reset
    user = User.first
    AppMailer.send_forgot_password(user)
  end
end