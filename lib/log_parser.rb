require 'byebug'

class LogParser

  def initialize(file)
    @file = file.read
  end

  def parse
    read_file
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

    def read_file
      games = []
      @file.each_line do |line|
        puts line
        if new_game? line
          games << Game.new
        elsif player_changed? line
          games.last.add_player get_player(line)
        end
      end
      games
    end
end