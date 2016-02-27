require 'spec_helper'
require 'log_parser'

describe 'My behaviour' do
  let!(:parser) do
    file = fixture 'first_game.log'
    LogParser.new file
  end

  it 'should do something' do
    parser.parse
  end
end