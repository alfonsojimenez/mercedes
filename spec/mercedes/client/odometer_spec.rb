require 'spec_helper'

RSpec.describe Mercedes::Client::Odometer do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#odometer' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/odometer" }

    let(:body) do
      {
        odometer: {
          value: 3003,
          retrievalstatus: 'VALID',
          timestamp: 1513343036,
          unit: 'KILOMETERS'
        },
        distancesincereset: {
          value: 1234,
          retrievalstatus: 'VALID',
          timestamp: 1513343036,
          unit: 'KILOMETERS'
        },
        distancesincestart: {
          value: 276,
          retrievalstatus: 'VALID',
          timestamp: 1513343036,
          unit: 'KILOMETERS'
        }
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.odometer(vehicle_id: vehicle_id) }

    it 'returns vehicle odometer information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
