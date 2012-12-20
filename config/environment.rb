# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
VandpibeCafe::Application.initialize!

WillPaginate.per_page = 10
