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

    it 'should have kill by means "MOD_TRIGGER_HURT": 7, "MOD_ROCKET_SPLASH": 3 and "MOD_FALLING": 1 ' do
      kill_by_means = game.kills_by_means
      expect(kill_by_means['MOD_TRIGGER_HURT']).to eq 7
      expect(kill_by_means['MOD_ROCKET_SPLASH']).to eq 3
      expect(kill_by_means['MOD_FALLING']).to eq 1
    end

    it 'should equal json' do
      json = "{\"game_1\":{\"total_kills\":11,\"players\":[\"Isgalamido\",\"Mocinha\"],\"kills_by_means\":{\"MOD_TRIGGER_HURT\":7,\"MOD_ROCKET_SPLASH\":3,\"MOD_FALLING\":1},\"kills\":{\"Isgalamido\":-7,\"Mocinha\":0}}}"
      expect(parser.parse_to_json).to eq json
    end
  end

  describe 'parse log with many games' do
    let(:parser) do
      file = fixture 'games.log'
      LogParser.new file
    end

    it 'should have 21 games' do
      games = parser.parse
      expect(games.length).to eq 21
    end
  end
end