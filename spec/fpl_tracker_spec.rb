require './fpl_tracker'

RSpec.describe FplTracker do

  subject { described_class}

  let(:response) { double(:http_client) }
  let(:response_parser) { double(ResponseParser) }
  let(:message) { double(Message) }

  describe '.run' do
    it 'calls Notification with formatted data from the api' do
      expect(HTTParty).to receive(:get).and_return(response)
      expect(ResponseParser)
        .to receive(:parse)
        .with(response)
        .and_return(response_parser)

      expect(Message)
        .to receive(:format)
        .with(response_parser)
        .and_return(message)

      expect(Notification).to receive(:mms).with(message)
      subject.run
    end
  end
end
