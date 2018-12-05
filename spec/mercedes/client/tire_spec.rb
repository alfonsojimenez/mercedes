require 'spec_helper'

RSpec.describe Mercedes::Client::Tire do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#tires' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/tires" }

    let(:body) do
      {
        tirepressurefrontleft: {
          value: 200,
          retrievalstatus: 'VALID',
          timestamp: 1512747349,
          unit: 'KILOPASCAL'
        },
        tirepressurefrontright: {
          value: 230,
          retrievalstatus: 'VALID',
          timestamp: 1512747349,
          unit: 'KILOPASCAL'
        },
        tirepressurerearright: {
          value: 230,
          retrievalstatus: 'VALID',
          timestamp: 1512747349,
          unit: 'KILOPASCAL'
        },
        tirepressurerearleft: {
          value: 230,
          retrievalstatus: 'VALID',
          timestamp: 1512747349,
          unit: 'KILOPASCAL'
        }
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.tires(vehicle_id: vehicle_id) }

    it 'returns vehicle tires information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
