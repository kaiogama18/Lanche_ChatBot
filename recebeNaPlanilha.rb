require_relative './process_request'
require("bundler")
require 'json'
Bundler.require
# app.rb
def ReceberMenu(messengerID)
	#Receber o total de linha da tabela

	message = {
		"recipient":{
				"id": messengerID
		},
		"message":{
				"text": 'Pão com ovo - Custo R$ 3,00 unid'
		}
	}

	message = {
		"recipient":{
				"id": messengerID
		},
		"message":{
				"text": 'Café Preto'
		}
	}
end

def enviar_messagen(messengerID,texto,numero_linha)
	contador = numero_linha
	message = {
		"recipient":{
				"id": messengerID
		},
		"message":{
				"text": 'oi'
		}
	}
end

def ChamarPedido(messengerID)
	puts messengerID
	objJson = {
		:recipient => {:id   => messengerID},
		:message   => {
			:text => "Escolhar a opção",
			:quick_replies => [
				{
					:content_type => "text",
        			:title =>"Comprar",
        			:payload =>"messaging_postbacks"
				},
				{
					:content_type => "text",
        			:title =>"Ver pedido",
        			:payload =>"messaging_postbacks"
				},
				{
					:content_type => "text",
        			:title =>"Cancelar",
        			:payload =>"messaging_postbacks"
				}
			]
		}	
	}
	return objJson
end


