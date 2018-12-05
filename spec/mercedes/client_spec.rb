require 'spec_helper'

RSpec.describe Mercedes::Client do
  describe '#initialize' do
    before do
      Mercedes.configure do |config|
        config.token = 'foo123'
      end
    end

    context 'when no options are given' do
      subject { Mercedes::Client.new }

      it 'sets global options' do
        Mercedes::Configurable::OPTIONS.each do |key|
          expect(subject.send(key)).to eq(Mercedes.send(key))
        end
      end
    end

    context 'when custom options are given' do
      subject { Mercedes::Client.new(token: 'foo345') }

      it 'sets local options' do
        Mercedes::Configurable::OPTIONS.each do |key|
          expect(subject.send(key)).not_to eq(Mercedes.send(key))
        end
      end
    end
  end
end
