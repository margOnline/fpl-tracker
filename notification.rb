require 'RMagick'
require 'dotenv/load'
require 'twilio-ruby'
require 'imgur'

ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID'].freeze
AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN'].freeze
TWILIO_PHONE_NUMBER = ENV['TWILIO_PHONE_NUMBER'].freeze
MY_PHONE_NUMBER = ENV['MY_PHONE_NUMBER'].freeze
IMGUR_CLIENT_KEY = ENV['IMGUR_CLIENT_KEY']

module Notification
  IMAGE_PATH = './updates.png'.freeze

  def self.mms(players)
    players.map!{ |player| player_message(player) }
    generate_image(players)

    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    client.messages.create(
      from: TWILIO_PHONE_NUMBER,
      to: MY_PHONE_NUMBER,
      body: 'Your fpl price updates are in!',
      media_url: upload_image
    )
  end

  def self.generate_image(infos)
    canvas = Magick::Image.new(480, 60 + infos.count * 30) {self.background_color = 'white'}
    gc = Magick::Draw.new
    gc.pointsize(20)

    infos.each_with_index do |info, index|
      
      gc.text(10, 60 + index * 30, info.center(11))
    end

    gc.draw(canvas)
    canvas.write(IMAGE_PATH)
  end

  def self.upload_image
    client = Imgur.new(IMGUR_CLIENT_KEY)
    image = Imgur::LocalImage.new(IMAGE_PATH, title: 'fpl-api update')
    up = client.upload(image)
    up.link
  end

  private

  def self.player_message(player)
    "#{player[:name]} (#{player[:team]}) now costs #{player[:salary]}"
  end
end