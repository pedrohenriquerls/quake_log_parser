require 'spec_helper'
require 'log_parser'

describe LogParser do
  describe 'parse log with one game' do
    let(:parser) do
      file = fixture 'first_game.log'
      LogParser.new file
    end
    let(:game) do
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

    # it 'should equal json' do
    #   json_game = "{\"total_kills\":11,\"players\":[\"Isgalamido\",\"Mocinha\"],\"kills\":{\"Isgalamido\":-7,\"Mocinha\":0}}"
    #   expect(game.to_json).to eq json_game
    # end

    it 'should equal json' do
      json = "{\"game_1\":{\"total_kills\":11,\"players\":[\"Isgalamido\",\"Mocinha\"],\"kills\":{\"Isgalamido\":-7,\"Mocinha\":0}}}"
      expect(parser.parse_to_json).to eq json
    end
  end
end