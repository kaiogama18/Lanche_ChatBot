require_relative './facebook'
require_relative 'insereNaPlanilha'
require_relative 'recebeNaPlanilha'
require_relative 'menu'
require_relative 'formulario'
require 'pp'

class ProcessRequest  
   def request(request_json)
     fb = Facebook.new
      #Tentar fazer uma função
      messengerID = fb.parseGetId(request_json) #ID do usuário(único de cada usuário)
      messengerAction = fb.getActionUser(request_json) # Ação do usuário
      #jsonNme = fb.getIdData(messengerID)
       #puts '=========== REQUEST ================'
       #pp request_json
       #puts '=========== REQUEST END=============='
      case messengerAction
        when 'action-pedir-almoco'
         	#messengerNome = fb.getNome(request_json) 
      	  messagerPedido = fb.getPedido(request_json) 
          inserirDadosNaPlanilha(messagerPedido)
          messageText = 'Seu pedido foi salvo na planilha com sucesso'
      	  fb.post(fb.messageText(messengerID,messageText))
        when 'action-pedido'
          puts messengerID
          fb.post(ChamarPedido(messengerID))
          #fb.post(fb.messageText(messengerID,messageText))
        end
        pedido = VerficarMenu(messengerAction)
        inserirDadosNaPlanilha(pedido)
     end 
end