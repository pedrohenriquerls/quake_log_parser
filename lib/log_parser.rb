require 'byebug'

class LogParser

  def initialize(file)
    @file = file.read
  end

  def parse
    read_file
  end

  def parse_to_json
    games = parse
    result = {}
    games.each_with_index do |game, index|
      result["game_#{index+1}"] = game.to_hash
    end

    result.to_json
  end

  private
    def new_game?(line)
      line=~/^\s{0,2}\d{1,3}:\d{2} InitGame:/ ? true : false
    end

    def player_changed?(str)
      str=~/^(\d{3}|\s\d{2}|\s{2}\d{1}):\d{2} ClientUserinfoChanged:/ ? true : false
    end

    def get_player(line)
      [line[/\d{1,2} n\\/].gsub(/ n\\/, '').to_i ,line[/n\\.+\\t\\\d/].gsub(/^n\\|\\t\\\d/, '')]
    end

    def kill?(line)
      line=~/^ \d{1,3}:\d{2} Kill:/ ? true : false
    end

    def get_kill_report(line)
      parsed_line = line[/Kill: \d{1,4}\s\d{1,2}\s\d{1,2}/].gsub(/^Kill: /, '').split(' ').map{ |i| i.to_i }
      parsed_line << line[/\d{1,3}:\d{2}/].gsub(/^Kill: /, '')
    end

    def read_file
      games = []
      @file.each_line do |line|
        if new_game? line
          games << Game.new
        elsif player_changed? line
          games.last.add_or_update_player get_player(line)
        elsif kill? line
          games.last.update_kills get_kill_report(line)
        end
      end
      games
    end
end