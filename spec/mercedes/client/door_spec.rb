require 'spec_helper'

RSpec.describe Mercedes::Client::Door do
  let(:vehicle_id) { 'ABC123' }
  let(:client) { Mercedes::Client.new(token: 'foobar123') }
  let(:url) { "#{Mercedes::Client::BASE_URL}vehicles/#{vehicle_id}/doors" }

  describe '#doors' do
    let(:body) do
      {
        doorstatusfrontleft: {
          value: 'CLOSED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorlockstatusfrontleft: {
          value: 'UNLOCKED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorstatusfrontright: {
          value: 'CLOSED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorlockstatusfrontright: {
          value: 'UNLOCKED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorstatusrearright: {
          value: 'CLOSED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorlockstatusrearright: {
          value: 'UNLOCKED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorstatusrearleft: {
          value: 'CLOSED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorlockstatusrearleft: {
          value: 'UNLOCKED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        },
        doorlockstatusvehicle: {
          value: 'UNLOCKED',
          retrievalstatus: 'VALID',
          timestamp: 1512748531
        }
      }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.doors(vehicle_id: vehicle_id) }

    it 'returns vehicle doors status information' do
      stub_request(:get, url).to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end

  describe '#lock_doors' do
    let(:body) do
      { status: 'INITIATED' }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.lock_doors(vehicle_id: vehicle_id) }

    it 'locks vehicle doors' do
      stub_request(:post, url).with(body: { command: 'LOCK' }.to_json)
                              .to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end

  describe '#unlock_doors' do
    let(:body) do
      { status: 'INITIATED' }.to_json
    end

    let(:response) do
      {
        status: 200,
        body: body
      }
    end

    subject { client.unlock_doors(vehicle_id: vehicle_id) }

    it 'unlocks vehicle doors' do
      stub_request(:post, url).with(body: { command: 'UNLOCK' }.to_json)
                              .to_return(response)

      expect(subject).to be_ok
      expect(subject.body).to eq(body)
    end
  end
end
