class Player
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :photo
  attr_accessor :team_name
  attr_accessor :position
  attr_accessor :price
  attr_accessor :status
  attr_accessor :dreamteam_count
  attr_accessor :in_dreamteam

  POSITIONS = {
    1 => 'Goalkeeper',
    2 => 'Defender',
    3 => 'Midfielder',
    4 => 'Forward'
  }

  def initialize(args)
    @first_name = args[0]
    @last_name = args[1]
    @photo = args[2]
    @team_name = args[3]
    @position = args[4]
    @price = args[5]
    @status = args[6]
    @dreamteam_count = args[7]
    @in_dreamteam = args[8]
  end

  def fullname
    "#{first_name[0]}. #{last_name}"
  end

  def formatted_price
    "£#{price/10.0}M"
  end

  def position_id
    POSITIONS.key(position)
  end
end