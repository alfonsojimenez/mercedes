module Mercedes
  class Client
    module Odometer
      def odometer(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/odometer")
      end
    end
  end
end
