module AuthHelper
  def basic_auth(user, password)
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials user, password
    @credentials = credentials
  end
end
