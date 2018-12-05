require 'spec_helper'

RSpec.describe Mercedes::Client::Charge do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#charge' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/stateofcharge" }

    let(:body) do
      {
        stateofcharge: {
          value: 80,
          retrievalstatus: 'VALID',
          timestamp: 1512747982,
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

    subject { client.charge(vehicle_id: vehicle_id) }

    it 'returns vehicle charge information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
