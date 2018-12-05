require 'spec_helper'

RSpec.describe Mercedes::Client::Vehicle do
  let(:client) { Mercedes::Client.new(token: 'foobar123') }

  describe '#vehicles' do
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles" }

    let(:body) do
      [
        {
          id: 'ABCD123',
          licenseplate: '1167FCB',
          finorvin: '1HM1FA517HEBF4AF2'
        }
      ].to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.vehicles }

    it 'returns vehicles' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end

  describe '#vehicle' do
    let(:vehicle_id) { 'ABC123' }
    let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}" }

    let(:body) do
      {
        id: vehicle_id,
        licenseplate: '3458FNC',
        salesdesignation: 'E 400 4MATIC Limousine',
        finorvin: '1HM1FA517HEBF4AF2',
        nickname: 'mmueller',
        modelyear: '2017',
        colorname: 'iridiumsilber metallic',
        fueltype: 'Benzin',
        powerhp: '333',
        powerkw: '245',
        numberofdoors: '5',
        numberofseats: '5'
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.vehicle(vehicle_id) }

    it 'returns vehicle information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
