require 'spec_helper'
require 'log_parser'

describe LogParser do
  describe 'parse log with one game' do
    let(:game) do
      file = fixture 'first_game.log'
      parser = LogParser.new file
      parser.parse.first
    end

    it 'should have one game and two players' do
      expect(game.nil?).to be false
      expect(game.players.length).to eq 2
    end

    it 'should have 11 kills' do
      expect(game.total_kills).to eq 11
    end

    it 'should have players called "Isgalamido" and "Mocinha"' do
      expect(game.players_name).to match_array ['Isgalamido', 'Mocinha']
    end
  end
end