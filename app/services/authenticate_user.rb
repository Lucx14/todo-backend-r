class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return unless user

    auth_token = JsonWebToken.encode(user_id: user.id)
    data = JsonWebToken.decode(auth_token)
    {
      auth_token: auth_token,
      data: data
    }
  end

  private

  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Messages::AuthMessages.invalid_credentials)
  end
end
