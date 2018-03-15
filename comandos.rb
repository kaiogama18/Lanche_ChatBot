require "brcep"
require "cpf_cnpj"

class Comandos
    # ----------------------------------------------------------------------
    #
    # Função para validar o Cpf
    #
    # -----------------------------------------------------------------------
    def Cpf(tag,texto)
        aux = texto.to_s
        comeco = "Cpf "
        if tag == "action-cpf"        
            total = texto.to_i
            total = total.size
            if total == 14 
                aux2 = " válido"
                resultado = (comeco + aux + aux2)
            elsif aux.size == 11
                aux2 = " válido"
                resultado = (comeco + aux + aux2)  
            else
                aux2 = " inválido"
                resultado = (comeco + aux + aux2)
            end    
            return resultado.to_s
        end
    end    
    # ----------------------------------------------------------------------
    #
    # Função para validar o Cep
    #
    # -----------------------------------------------------------------------
    def Cep(tag,texto)
        if tag == "action-cep"
            cep = texto.to_i
            endereco = BuscaEndereco.cep(cep)
            autenticado = endereco.to_s
            str = autenticado
            aux = str.gsub(/{:tipo_logradouro=>/, "Endereço: ")
            aux = aux.gsub(/"/, "")
            aux = aux.gsub(/, :logradouro=>/, " ")     
            aux = aux.gsub(/ :bairro=>/, " ")
            aux = aux.gsub(/ :cidade=>/, " Cidade: ")
            aux = aux.gsub(/, :uf=>/, ", Estado: ")
            aux = aux.gsub(/, :cep=>/, ", Cep informado: ")
            aux = aux.gsub(/}/, "")
            return aux
        end
    end
    # ----------------------------------------------------------------------
    #
    # Função para validar o Cnpj
    #
    # -----------------------------------------------------------------------
    def Cnpj(tag,texto)
        aux = texto.to_s
        comeco = "Cnpj "
        if tag == "action-cnpj"        
            total = texto.to_i
            total = total.size
            if total == 18 
                aux2 = " válido"
                resultado = (comeco + aux + aux2)
            elsif aux.size == 14
                aux2 = " válido"
                resultado = (comeco + aux + aux2)  
            else
                aux2 = " inválido"
                resultado = (comeco + aux + aux2)
            end    
            return resultado.to_s
        end
    end
    # ----------------------------------------------------------------------
    #
    # Função para validar o Rua
    #
    # -----------------------------------------------------------------------
    def Rua(tag_resposta)
        aux = tag_resposta
        aux = aux.gsub(/rua /, "Rua+")
        aux = aux.gsub(/Rua /, "rua+")
        aux = aux.gsub(/ /, "+")
        aux = aux.gsub(/ã/, "%C3%A3")
        aux = aux.gsub(/ã/, "%C3%A3")
        return final = "https://www.google.com.br/search?ei=u72qWpCmI4uDwgT4nLrACg&q="+aux+"+manaus&oq="+aux+"+manaus&gs_l=psy-ab.3...0.0.0.125973.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.qOUW-MpAZxk"
    end

    def ObjJsonNow(messengerID, texto)
        objJson = {
            :recipient => {:id  => messengerID},
            :message   => {
                :attachment =>{
                    :type => "archive", 
                    :payload =>{
                      :url => texto, 
                      :is_reusable => true
                    }
                }
            }
        }
        return objJson
    end
end




