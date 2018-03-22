require 'net/http'
require 'uri'

FB_GRAPH        = 'https://graph.facebook.com'
FB_MESSAGES     = 'https://graph.facebook.com/v2.10/me/messages'
#Chave para o facebook Igor
#FB_ACCESS_TOKEN = 'EAAFPp0gLttwBAPO0bkZBu9k4jKVeTrDO4vM5cjin3KhJvreN06RdZCKiKRZAW9xsSDYeQmzGe46nkeFomsmbmjRVVil5hCkCl8I1z7A8IJI1MZAmABAMHrnZBoVzgIA3r6ZB8zZAQPAegM6wnApp7DTf3aP5Xfc1NLf2ZBphBgGKZBAZDZD'
#Chave para o facebook Eduardo
# FB_ACCESS_TOKEN = 'EAAFZCxMnvC94BAD0H6ciasGQbIZBA4aUbbLrlckRf8DpgbesPFtfMfyLiaCb1nyn3WLeHjY0VXTTN51ZBe7QYFxSc5OhqQa4Pp2U5rJGuqGrMBYnL2lkb3RnuktXPzkpCADZCBuZBvZB9MNJo9nLlHm3s0v5MawXYbot52A3Rz2QZDZD'

#Chave para o bemo.facebook Eduardo
FB_ACCESS_TOKEN = 'DQVJ1dFBwR2RvMlpYcFpYVS02eEM0WU9xZA08wbVN1VTNjWE9IdklSLXc2ODZAFTHFUV1E4YmhTdmI1aC1udlhkTlNEdTFOaWFBaEVUWDdGSmxmSXI4TWxRb04yQS1feTlyYW9SeU4wcmpzM3hSdlpxa2dKVC1GbkUxSkcyM3ozQWFscUNoRGxhNkZA4eVFoWFA0bHV1blFHSXlWdGFod0xWNFY2VDB1QmxoQ2JzeXRZAWlpMTDA4cjJ4UFRSN3ROcWN2ajFpNUxR'
class Facebook

  def post(objJson)
    uri = URI.parse(FB_MESSAGES+"?access_token="+FB_ACCESS_TOKEN)

    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump(objJson)
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
      http.finish
    end
    # puts response.code
    # puts response.body
  end

  
  def getIdData(id)
    uri = URI.parse(FB_GRAPH+"/"+id)
    params = {:fields => "name,email", :access_token => FB_ACCESS_TOKEN}

    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    # puts response.body if response.is_a?(Net::HTTPSuccess)
    return response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body,symbolize_names: true) : ""
  end


  def messageText(messengerID, text)
    objJson = {
      :recipient => {:id   => messengerID},
      :message   => {:text => text}
    }
    return objJson
  end


  #Pega o id do usuário pra fazer algo...
    def parseGetId(request_json)
      messengerID = ""
      request_json[:result][:contexts].each do |row|
        messengerID = row[:parameters][:facebook_sender_id] if row[:parameters].key? :facebook_sender_id
      end
      return messengerID
    end


    # *****************************************************************************************************************************************************************
    def parseGetRespostaUser(request_json,value)
        value = (":"+value)
        resposta = ""
        puts ("=>" + value)

        request_json[:result][:contexts].each do |row|
    
          resposta = row[:parameters][value] if row[:parameters].key? value
    
        end

      return resposta

    end

    # *****************************************************************************************************************************************************************

    def parseGetMenu(request_json)
      menu = ""
      request_json[:result][:contexts].each do |row|
        menu = row[:parameters][:MENU] if row[:parameters].key? :MENU
      end
      return menu   
    end  


  #Pega a ação  do usuário pra fazer algo...
    def getActionUser(request_json)
      messengerActionUser = ""
        messengerActionUser = request_json[:result][:action] if request_json[:result].key? :action
      return messengerActionUser
    end   

   #Fazer uma função PARA NAVEGAR NO JSON.. UM FUNÇÃO MAIS GENÊRICA..
   #INFORMAR AQUI SOMENTE OS PARÁMETROS QUE EU QUERO , ENVIADOS DE OUTRA FUNÇÃO.


    def getPedido(request_json)
      messengerPedido = ""
      request_json[:result][:contexts].each do |row|
        messengerPedido = row[:parameters][:pedido] if row[:parameters].key? :pedido
        #Se ele encontrar na linha parâmetro o cep... Retorna o cep. o Parãmetro pe o que o usuário digita. o cep foi definido la no dialod...
      end
      return messengerPedido
    end

    def getActionContent(request_json,action)
      pedido = ""
      action = (":"+action)
      puts action
      request_json[:result][:contexts].each do |row|
        pedido = row[:parameters][action] if row[:parameters].key? action
      end
      return pedido
    end

    #Recebe a messagens que o usuario informou
    def parseGetResposta(request_json)
      resposta = ""
      resposta = request_json[:result][:resolvedQuery]
        return resposta
    end

end