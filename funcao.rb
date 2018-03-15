require 'net/http'
require 'uri'

FB_GRAPH        = 'https://graph.facebook.com'
FB_MESSAGES     = 'https://graph.facebook.com/v2.10/me/messages'
FB_ACCESS_TOKEN = 'EAAbPeabl9AkBAOInGonuGJbcYaZCw1QmnboteBBvExnb51bSmsPOU8FHHCO2clZBsZBnskMzoF4GPB7rzy79Bp2LyGMuMm9sMw6H79WSsIinnGHjs9am8KPeHjqbVhRqxzJjjyrnslhAWhFIUEN6BkVGN27moxluig9emlb4gZDZD'

class Conexao

  def post(objJson)
    uri = URI.parse('https://graph.facebook.com/v2.10/me/messages'+"?access_token=EAAbPeabl9AkBAOkp0I0ZCRnNuZAu557jwzQ4csTxJ1w93eTTHOWScJ8FRP4ZAAODLBZAtmkSnPCDaK0N1t3fJ8xwPpBVFCXZAOIeb2TbLN9TH49CH2lnC1CxpIqAGS1SdRlvVdgZAcB1tyFPfCitcKmSUJyIONAdSdFE7MIItnowZDZD")
        
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
  end


  def getIdData(id)
    uri = URI.parse(Helper::FB_GRAPH+"/"+id)
    params = {:fields => "name,email", :access_token => "EAAbPeabl9AkBAOInGonuGJbcYaZCw1QmnboteBBvExnb51bSmsPOU8FHHCO2clZBsZBnskMzoF4GPB7rzy79Bp2LyGMuMm9sMw6H79WSsIinnGHjs9am8KPeHjqbVhRqxzJjjyrnslhAWhFIUEN6BkVGN27moxluig9emlb4gZDZD"}

    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    return response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body,symbolize_names: true) : ""
  end

  def messageText(messengerID, text)
    objJson = {
      :recipient => {:id   => messengerID},
      :message   => {:text => text}
    }
    return objJson
  end

  def parseGetId(request_json)
    messengerID = ""
    request_json[:result][:contexts].each do |row|
      messengerID = row[:parameters][:facebook_sender_id] if row[:parameters].key? :facebook_sender_id
    end
    return messengerID
  end

  def parseGetTagCep(request_json)
    cep = ""
    request_json[:result][:contexts].each do |row|
      cep = row[:parameters][:CEP] if row[:parameters].key? :CEP
    end
    return cep
  end

  def parseGetTagCpf(request_json)
    cpf = ""
    request_json[:result][:contexts].each do |row|
      cpf = row[:parameters][:CPF] if row[:parameters].key? :CPF
    end
    return cpf
  end

  def parseGetTagCnpj(request_json)
    cnpj = ""
    request_json[:result][:contexts].each do |row|
      cnpj = row[:parameters][:CNPJ] if row[:parameters].key? :CNPJ
    end
    return cnpj
  end

  def parseGetTagRua(request_json)
    rua = ""
    request_json[:result][:contexts].each do |row|
      rua = row[:parameters][:RUA] if row[:parameters].key? :RUA
    end
    return rua
  end

  def parseGetAction(request_json)
    action = ""
     action = request_json[:result][:action]
    return action
  end

  def parseGetResposta(request_json)
    resposta = ""
    resposta = request_json[:result][:resolvedQuery]
      return resposta
  end


end


