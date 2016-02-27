class Player
  attr_accessor :name, :kills, :deaths

  def initialize(name)
    @name = name
    @kills = 0
    @deaths = 0
  end
end