require 'grape'

module V1
  class Base < Grape::API

    prefix :api
    format :json
    default_error_formatter :json

    helpers do
      def current_user
        api_key = headers['Authorization']&.split(' ')&.last
        @current_user ||= User.find_by(api_key: api_key)
      end

      def authenticate!
        error!('Unauthorized', 401) unless current_user
      end
    end

    # Mount the V1 API
    mount V1::Users
  end
end
