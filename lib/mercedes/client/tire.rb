module Mercedes
  class Client
    module Tire
      def tires(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/tires")
      end
    end
  end
end
