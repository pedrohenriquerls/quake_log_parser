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

  def add_or_update_player(parsed_line)
    player_name = parsed_line[1]
    player_key = parsed_line[0]
    if new_player? parsed_line
      @players[player_key] = Player.new(player_name)
    else
      @players[player_key].name = player_name
    end
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

  def to_hash
    game_hash = {
        total_kills: @total_kills,
        players: players_name,
        kills: {}
    }

    players.each do |key, player|
      game_hash[:kills][player.name] = player.kills
    end
    game_hash
  end

  def players_name
    @players.collect do |id, player|
      player.name
    end
  end
end