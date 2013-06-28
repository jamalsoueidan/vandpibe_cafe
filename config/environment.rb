# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
VandpibeCafe::Application.initialize!

WillPaginate.per_page = 10