
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
        
    when 'action-salgadodoce'    
    	puts '=========== Dentro da opção Salgado e Doce ================'
        puts messengerAction
        puts "O que está Mostrando
       " 
        puts '=========== Está Mostrando um Puts ================'
    	return 'true'
    end	
end

def FinalizarCompra(resposta,messengerID)
	if resposta == 'true'
		text = 'Deseja finalizar o pedido?'
		objJson = {
      		:recipient => {:id   => messengerID},
      		:message   => {:text => text}
    	}
    	return objJson
	end	
end
