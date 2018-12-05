require 'spec_helper'

RSpec.describe Mercedes::Client::Location do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#location' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/location" }

    let(:body) do
			{
				longitude: {
          value: 2.174356619282343,
					retrievalstatus: 'VALID',
					timestamp: 1513343380
				},
				latitude: {
          value: 41.403629059630311,
					retrievalstatus: 'VALID',
					timestamp: 1513343380
				},
				heading: {
					value: 62.1234,
					retrievalstatus: 'VALID',
					timestamp: 1513343380
				}
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.location(vehicle_id: vehicle_id) }

    it 'returns vehicle current location information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
