require 'grape'

module V1
  class Base < Grape::API

    prefix :api
    format :json
    default_error_formatter :json
  end
end
