require 'imgur'

class ImageProcessor
  IMGUR_CLIENT_KEY = ENV['IMGUR_CLIENT_KEY']
  IMAGE_PATH = './updates.png'.freeze

  def self.generate(infos)
    canvas = Magick::Image.new(480, 60 + infos.count * 30) {self.background_color = 'white'}
    gc = Magick::Draw.new
    gc.pointsize(20)

    infos.each_with_index do |info, index|
      gc.text(10, 60 + index * 30, info.center(11))
    end

    gc.draw(canvas)
    canvas.write(IMAGE_PATH)
  end

  def self.upload
    client = Imgur.new(IMGUR_CLIENT_KEY)
    image = Imgur::LocalImage.new(IMAGE_PATH, title: 'fpl-api update')
    up = client.upload(image)
    up.link
  end
end
