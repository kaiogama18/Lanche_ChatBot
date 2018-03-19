require_relative './process_request'

require("bundler")
Bundler.require


def Formulario_pt_1(aux)
    case aux
        when 'email'
           return "Informe o seu E-mail"
    end
end
