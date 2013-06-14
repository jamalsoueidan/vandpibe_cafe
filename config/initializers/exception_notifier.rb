if Rails.env.production?
	VandpibeCafe::Application.config.middleware.use(ExceptionNotifier, {
	  :email => {
	    :email_prefix => "Application Error ",
	    :sender_address => %{"notifier" <jamal@soueidan.com>},
	    :exception_recipients => %w{jamal@soueidan.com},
	  }
	})
end