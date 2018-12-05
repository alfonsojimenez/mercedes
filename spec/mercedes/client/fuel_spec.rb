require 'spec_helper'

RSpec.describe Mercedes::Client::Fuel do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#fuel' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/fuel" }

    let(:body) do
      {
        fuellevelpercent: {
          value: 40,
          retrievalstatus: 'VALID',
          timestamp: 1512747873,
          unit: 'PERCENT'
        }
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.fuel(vehicle_id: vehicle_id) }

    it 'returns vehicle fuel state information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
