require 'log_parser'

class LogController < ApplicationController
  def index
    fixture_path = File.expand_path('../../../spec/fixtures', __FILE__)
    parser = LogParser.new File.open(fixture_path + '/games.log')
    render json: parser.parse_to_json
  end
end