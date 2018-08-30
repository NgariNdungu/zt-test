class ApplicationController < ActionController::API
  # use knock for token authentication
  include Knock::Authenticable
end
