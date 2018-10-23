require 'sinatra'
require_relative 'solver'

get '/ok' do
  [200, 'ok']
end

post '/solve' do
  data = {}
  begin
    request.body.rewind
    data = JSON.parse request.body.read
  rescue
    return [400, 'Failure to parse request.']
  end
  return [412, 'Request must have "puzzle" key.'] unless data.has_key?('puzzle') and not data['puzzle'].empty?
  
  puzzle_solver = Solver.new(data["puzzle"])
end