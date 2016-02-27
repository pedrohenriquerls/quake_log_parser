class Game
  WORLD_KILL = 1022
  attr_accessor :players, :total_kills, :rank

  def initialize
    @players = {}
    @rank = []
    @total_kills = 0
  end

  def new_player?(parsed_line)
    @players[parsed_line[0]].nil?
  end

  def add_player(parsed_line)
    player_name = parsed_line[1]
    player_key = parsed_line[0]
    @players[player_key] = Player.new(player_name) if new_player? parsed_line
  end

  def update_kills(parsed_line)
    @total_kills += 1

    killer = @players[parsed_line[0]]
    killed = @players[parsed_line[1]]

    suicide = killer.try(:name) == killed.name

    unless suicide
      killed.deaths += 1
      if parsed_line[0] == WORLD_KILL
        killed.kills -= 1
      else
        killer.kills += 1
      end
    end
  end

  def players_name
    @players.collect do |id, player|
      player.name
    end
  end
end