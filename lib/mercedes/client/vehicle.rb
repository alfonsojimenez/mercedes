module Mercedes
  class Client
    module Vehicle
      def vehicles
        perform_request(:get, 'vehicles')
      end

      def vehicle(id)
        perform_request(:get, "vehicles/#{id}")
      end
    end
  end
end
