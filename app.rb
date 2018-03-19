# app.rb
require 'sinatra'
require 'thin'
require 'json'
require 'pp'
#require 'date'
#require 'base64'

require_relative './facebook'
require_relative 'process_request'

set :port, 5000

post "/webhook" do
	pq = ProcessRequest.new
	#fb = Facebook.new();
	request_payload =  "#{ request.body.read }" # Recebe o conteúdo do usuário JSON do usuário
	request_json = JSON.parse(request_payload,symbolize_names: true) # Transforma em JSON
	puts '=========== REQUEST ================'
	pp request_json
	puts '=========== REQUEST END============='
	pq.request(request_json)
end

get "/" do
  erb :index
end
# app.rb
def worksheet #folhaDeCalculo
  @session ||= GoogleDrive::Session.from_service_account_key("client_secret.json")
  @spreadsheet ||= @session.spreadsheet_by_title("Planilha de Pedidos") # planilha
  @worksheet ||= @spreadsheet.worksheets.first
end
# app.rb
post "/" do 
  new_row = [params["name"], params["pedido"]]
  begin
    worksheet.insert_rows(worksheet.num_rows + 1, [new_row])
    worksheet.save
    erb :thanks
  rescue
    erb :index, locals: {
      error_message: "Não inserido na planilha. Erro! Tente novamente"
    }
  end
end