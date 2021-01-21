require 'rails_helper'

RSpec.describe Factory do
  describe "#initialize" do
    it 'executeのメッセージを送信する' do
      pending
      allow(agent).to receive(:execute)
      Factory.new(agent: agent)
      expect(initialize).to have_received(:execute).once
    end
  end
end
