class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'  
    @body[:url]  = activate_url(user.activation_code)
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = root_url
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'You have requested to change your password'
    @body[:url]  = reset_password_url(user.password_reset_code)
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end

  def message_to_admin(user,subject,body)
    @admin       = User.find_by_login('admin')
    @recipients  = @admin.email
    @from        = @admin.email
    @subject     = "Blog - "
    @sent_on     = Time.now
    @subject    += subject
    @body[:user] = user
    @body[:body] = body
  end

protected
  def setup_email(user)
    # still surprised this isn't set somewhere by default ...
    ActionMailer::Base.default_url_options[:host] = "blog.jakewendt.com"
    @recipients  = "#{user.email}"
    @from        = @admin = User.find_by_login('admin').email
    @subject     = "Blog - "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
