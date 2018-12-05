module Mercedes
  class Client
    module Fuel
      def fuel(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/fuel")
      end
    end
  end
end
