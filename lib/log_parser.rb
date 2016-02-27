require 'byebug'

class LogParser

  def initialize(file)
    @file = file.read
  end

  def parse
    games = read_file
  end

  private
    def new_game?(line)
      line=~/^\s{0,2}\d{1,3}:\d{2} InitGame:/ ? true : false
    end

    def read_file
      games = []
      @file.each_line do |line|
        if new_game? line
          games << Game.new
        end
      end
    end
end