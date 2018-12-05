require 'spec_helper'

RSpec.describe Mercedes::Configurable do
  it 'allows to configure token' do
    expect(
      Mercedes::Configurable::OPTIONS
    ).to eq([:token])
  end

  describe '.configure' do
    described_class::OPTIONS.each do |key|
      before do
        Mercedes.configure { |config| config.send("#{key}=", key) }
      end

      it "sets #{key}" do
        expect(Mercedes.send(key)).to eq(key)
      end
    end
  end
end
