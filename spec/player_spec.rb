require './player'

RSpec.describe Player do

  subject { described_class.new(args)}

  let(:args) {
    ['Jon', 'Smith', 'x.jpg', 'Team Name', 'Forward', 56, 'a', 2, true]
  }

  describe '#fullname' do
    it 'returns a string consisting of first initial and last name' do
      expect(subject.fullname).to eq 'J. Smith'
    end
  end

  describe '#formatted_price' do
    it 'returns the price divided by 10 with a pound sign' do
      expect(subject.formatted_price).to eq '£5.6M'
    end
  end

  describe '#position_id' do
    it 'returns an integer representing the player\'s position' do
      expect(subject.position_id).to eq 4
    end
  end

end