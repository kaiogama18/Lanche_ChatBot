require_relative './process_request'
require("bundler")
require 'json'
Bundler.require

def VerficarMenu(messengerAction)
    case messengerAction
    when 'action-suco'
        puts "Suco adicionado"
    when 'action-coxinha'
        puts "Adicionado com sucesso a coxinha"
        return '1 unidade, coxinha - Custo R$0,25'
    end    
end

def ChamadaPergunta()
end