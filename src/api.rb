require 'sinatra'

get '/ok' do
  [200, 'ok']
end

post '/solve' do
  begin
    request.body.rewind
    data = JSON.parse request.body.read
    data['puzzle']
  rescue
    [400, 'Failure to parse request.']
  end
end