require_relative './facebook'
require_relative 'insereNaPlanilha'
require_relative 'recebeNaPlanilha'
require_relative 'menu'
require_relative 'formulario'
require 'pp'

class ProcessRequest  
   def request(request_json)
     fb = Facebook.new
      messengerID = fb.parseGetId(request_json) 
      messengerAction = fb.getActionUser(request_json)
      
      puts "< --------------------------------------------------------- >"
      mess = fb.parseGetRespostaUser(request_json,messengerAction)
      puts mess
      puts "< --------------------------------------------------------- >"


      puts "################# Dentro do ProcessRequest #################"
      resposta = VerficarMenu(messengerAction)
      # fb.post(FinalizarCompra(resposta,messengerID))
      puts ("========> "+resposta)
      aux =FinalizarCompra(resposta,messengerID)
      fb.post(aux) 
      puts "################# Fim do ProcessRequest #################"

      






      #jsonNme = fb.getIdData(messengerID)
       #puts '=========== REQUEST ================'
       #pp request_json
       #puts '=========== REQUEST END=============='
      # case messengerAction
      #   when 'action-pedir-almoco'
      #    	#messengerNome = fb.getNome(request_json) 
      # 	  messagerPedido = fb.getPedido(request_json) 
      #     inserirDadosNaPlanilha(messagerPedido)
      #     messageText = 'Seu pedido foi salvo na planilha com sucesso'
      # 	  fb.post(fb.messageText(messengerID,messageText))
      #   end

      
        #pedido = VerficarMenu(messengerAction)
        #inserirDadosNaPlanilha(pedido)


    end 
end