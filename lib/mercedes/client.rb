require 'mercedes/response'
require 'mercedes/client/charge'
require 'mercedes/client/door'
require 'mercedes/client/fuel'
require 'mercedes/client/location'
require 'mercedes/client/odometer'
require 'mercedes/client/tire'
require 'mercedes/client/vehicle'
require 'patron'

module Mercedes
  class Client
    include Client::Charge
    include Client::Door
    include Client::Fuel
    include Client::Location
    include Client::Odometer
    include Client::Tire
    include Client::Vehicle

    CarNotAvailable = Class.new(RuntimeError)
    NotFound = Class.new(RuntimeError)
    ServerError = Class.new(RuntimeError)
    Unauthorized = Class.new(RuntimeError)

    BASE_URL = 'https://api.mercedes-benz.com/experimental/connectedvehicle/v1/'
    TIMEOUT = 10

    attr_reader(*Configurable::OPTIONS)

    def initialize(options = {})
      Configurable::OPTIONS.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Mercedes.send(key))
      end

      http_client.base_url = BASE_URL
    end

    private

    def http_client
      @http_client ||= Patron::Session.new do |config|
        config.timeout = TIMEOUT
        config.headers = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'authorization' => "Bearer #{@token}"
        }
      end
    end

    def perform_request(method, url, params = {})
      handle_errors do
        Response.new(http_client.request(method, url, {}, params))
      end
    end

    def handle_errors
      yield.tap do |response|
        if response.request_timeout?
          raise CarNotAvailable, 'Car is not available because it is not connected to simulator'
        elsif response.unauthorized?
          raise Unauthorized, 'Unauthorized'
        elsif response.server_error?
          raise ServerError, 'Server is not available'
        elsif response.not_found?
          raise NotFound, 'Resource not found'
        end
      end
    end
  end
end
