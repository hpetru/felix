class Users::SessionsController < Devise::SessionsController
  skip_before_filter :require_login
  layout 'empty'
end
