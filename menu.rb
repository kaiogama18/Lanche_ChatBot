
require_relative './process_request'
require("bundler")
require 'json'
Bundler.require

def VerficarMenu(messengerAction)
    case messengerAction
        when 'action_salgadodoce'    
    	   puts '=========== Dentro da opção Salgado e Doce ================'
            puts ("----------------> "+messengerAction)
            puts '=========== Fim da opção Salgado e Doce ================'
    	   return 'true'
        when 'action-bolosanduiche'
            puts '=========== Dentro da opção Bolo Sanduiche ================'
            puts ("----------------> "+messengerAction)
            puts '=========== Fim da opção Bolo Sanduiche ================'
            return 'true'
        when 'action-bebida'
            puts '=========== Dentro da opção action-bebida ================'
            puts ("----------------> "+messengerAction)
            puts '=========== Fim da opção Bebida ================'
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
