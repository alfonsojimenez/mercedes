module Mercedes
  class Client
    module Location
      def location(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/location")
      end
    end
  end
end
