require 'spec_helper'
require 'log_parser'

describe LogParser do
  describe 'parse log with one game' do
    let!(:parser) do
      file = fixture 'first_game.log'
      LogParser.new file
    end

    it 'should have one game and two players' do
      games = parser.parse
      expect(games.length).to eq 1
      expect(games.first.players.length).to eq 2
    end
  end
end