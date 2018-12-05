module Mercedes
  class Client
    module Door
      def doors(vehicle_id:)
        perform_request(:get, "vehicles/#{vehicle_id}/doors")
      end

      def lock_doors(vehicle_id:)
        perform_request(:post, "vehicles/#{vehicle_id}/doors", data: { command: 'LOCK' }.to_json)
      end

      def unlock_doors(vehicle_id:)
        perform_request(:post, "vehicles/#{vehicle_id}/doors", data: { command: 'UNLOCK' }.to_json)
      end
    end
  end
end
