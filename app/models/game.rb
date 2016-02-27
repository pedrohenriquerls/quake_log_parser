class Game
  attr_accessor :players, :player_kills, :world_kills, :rank

  def initialize
    @players = {}
    @rank = []
    @player_kills = 0
    @world_kills = 0
  end

  def new_player?(parsed_line)
    @players[parsed_line[0]].nil?
  end

  def add_player(parsed_line)
    player_name = parsed_line[1]
    player_key = parsed_line[0]
    @players[player_key] = Player.new(player_name) if new_player? parsed_line
  end
end