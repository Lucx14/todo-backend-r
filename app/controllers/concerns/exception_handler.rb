module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end

  class MissingToken < StandardError; end

  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_transaction

    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :invalid_transaction
    rescue_from ExceptionHandler::InvalidToken, with: :invalid_transaction
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  private

  def invalid_transaction(err)
    render json: {
      message: err.message
    }, status: :unprocessable_entity
  end

  def unauthorized_request(err)
    render json: {
      message: err.message
    }, status: :unauthorized
  end

  def not_found(err)
    render json: {
      message: err.message
    }, status: :not_found
  end
end
