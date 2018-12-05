module Mercedes
  class Client
    module Charge
      def charge(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/stateofcharge")
      end
    end
  end
end
