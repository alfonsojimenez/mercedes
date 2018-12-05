require 'spec_helper'

RSpec.describe Mercedes::Response do
  let(:response) { double }

  subject { Mercedes::Response.new(response) }

  describe '#json' do
    let(:response) do
      double(body: '{"foo":"bar"}')
    end

    it 'returns response parsed body' do
      expect(subject.json).to eq('foo' => 'bar')
    end
  end

  describe '#ok?' do
    context 'when response code is 200' do
      before { expect(response).to receive(:status).and_return(200) }

      it { expect(subject).to be_ok }
    end

    context 'when response code is not 200' do
      before { expect(response).to receive(:status).and_return(404) }

      it { expect(subject).not_to be_ok }
    end
  end

  describe '#created?' do
    context 'when response code is 201' do
      before { expect(response).to receive(:status).and_return(201) }

      it { expect(subject).to be_created }
    end

    context 'when response code is not 201' do
      before { expect(response).to receive(:status).and_return(404) }

      it { expect(subject).not_to be_created }
    end
  end

  describe '#unauthorized?' do
    context 'when response code is 401' do
      before { expect(response).to receive(:status).and_return(401) }

      it { expect(subject).to be_unauthorized }
    end

    context 'when response code is not 401' do
      before { expect(response).to receive(:status).and_return(200) }

      it { expect(subject).not_to be_unauthorized }
    end
  end

  describe '#no_content?' do
    context 'when response code is 204' do
      before { expect(response).to receive(:status).and_return(204) }

      it { expect(subject).to be_no_content }
    end

    context 'when response code is not 204' do
      before { expect(response).to receive(:status).and_return(404) }

      it { expect(subject).not_to be_no_content }
    end
  end

  describe '#not_found?' do
    context 'when response code is 404' do
      before { expect(response).to receive(:status).and_return(404) }

      it { expect(subject).to be_not_found }
    end

    context 'when response code is not 404' do
      before { expect(response).to receive(:status).and_return(200) }

      it { expect(subject).not_to be_not_found }
    end
  end

  describe '#request_timeout?' do
    context 'when response code is 408' do
      before { expect(response).to receive(:status).and_return(408) }

      it { expect(subject).to be_request_timeout }
    end

    context 'when response code is not 408' do
      before { expect(response).to receive(:status).and_return(200) }

      it { expect(subject).not_to be_request_timeout }
    end
  end

  describe '#server_error?' do
    context 'when response code is 500' do
      before { expect(response).to receive(:status).and_return(500) }

      it { expect(subject).to be_server_error }
    end

    context 'when response code is greater than 500' do
      before { expect(response).to receive(:status).and_return(501) }

      it { expect(subject).to be_server_error }
    end

    context 'when response code is less than 500' do
      before { expect(response).to receive(:status).and_return(400) }

      it { expect(subject).not_to be_server_error }
    end
  end
end
