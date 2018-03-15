require 'sinatra'
require 'thin'
require 'json'
require 'pp'

require_relative './funcao'
set :port, 9000

#require_relative './comandos'


post '/webhook' do 
    fb = Conexao.new();
    comando = Comandos.new();
    request_payload =  "#{ request.body.read }"
    request_json = JSON.parse(request_payload,symbolize_names: true)
    tag = fb.parseGetAction(request_json)
    messengerID = fb.parseGetId(request_json)
    messageText = "Bem vindo"
    fb.post(fb.messageText(messengerID,messageText))
end