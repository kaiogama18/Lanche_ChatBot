require_relative './process_request'

require("bundler")
Bundler.require

# app.rb
def worksheet #folhaDeCalculo
  @session ||= GoogleDrive::Session.from_service_account_key("client_secret.json")
  @spreadsheet ||= @session.spreadsheet_by_title("Pedidos") # planilha
  @worksheet ||= @spreadsheet.worksheets.first
end

def inserirDadosNaPlanilha(pedido)
	  new_row = [pedido, 'TESTE']
	  #params = {:any => "name,email", :access_token => FB_ACCESS_TOKEN}
	  begin
	    worksheet.insert_rows(worksheet.num_rows + 1, [new_row])
	    worksheet.save
	  rescue
	    error = "Algo errado aconteceu!."
	  end
end