class ApplicationController < ActionController::Base
	helper :all # include all helpers, all the time

	include AuthenticatedSystem
	# don't show passwords in logs
	filter_parameter_logging 'password'

	# See ActionController::RequestForgeryProtection for details
	# Uncomment the :secret if you're not using the cookie session store
	protect_from_forgery # :secret => 'afe76908822b45fd48062836e82f84bd'

	# I put this here so that *_url works in app/models/user_mailer.rb
# I moved it to user_mailer.rb
#	ActionMailer::Base.default_url_options[:host] = "blog.jakewendt.com"
#	ActionMailer::Base.default_url_options[:host] = "localhost:3000"

protected
	def get_pages
		@pages = Page.find(:all, :order => :position)
	end
end
