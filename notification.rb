require 'RMagick'
require 'dotenv/load'
require 'twilio-ruby'
require './image_processor'

class Notification
  ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID'].freeze
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN'].freeze
  TWILIO_PHONE_NUMBER = ENV['TWILIO_PHONE_NUMBER'].freeze
  MY_PHONE_NUMBER = ENV['MY_PHONE_NUMBER'].freeze  

  def self.mms(message)
    ImageProcessor.generate(message)

    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    client.messages.create(
      from: TWILIO_PHONE_NUMBER,
      to: MY_PHONE_NUMBER,
      body: message.join("\n")
      # media_url: ImageProcessor.upload
    )
  end
end
