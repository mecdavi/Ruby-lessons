# Metaprogramação em Ruby

# Definindo métodos dinamicamente
class Usuario
  attr_accessor :nome, :email, :idade

  def initialize(nome, email, idade)
    @nome = nome
    @email = email
    @idade = idade
  end

  # Definindo métodos dinamicamente
  %w[admin moderador usuario].each do |tipo|
    define_method("#{tipo}?") do
      @tipo == tipo
    end
  end

  # Método que responde a qualquer chamada
  def method_missing(nome, *args)
    if nome.to_s.start_with?('tem_')
      atributo = nome.to_s[4..-1]
      respond_to?(atributo) ? send(atributo) : super
    else
      super
    end
  end

  # Verificando se o método existe
  def respond_to_missing?(nome, include_private = false)
    nome.to_s.start_with?('tem_') || super
  end
end

# Usando a classe com metaprogramação
usuario = Usuario.new("João", "joao@email.com", 25)
usuario.instance_variable_set(:@tipo, "admin")

puts "É admin? #{usuario.admin?}"
puts "É moderador? #{usuario.moderador?}"
puts "Tem nome? #{usuario.tem_nome}"
puts "Tem idade? #{usuario.tem_idade}"

# Eval e class_eval
class Produto
  attr_accessor :nome, :preco
end

# Adicionando métodos dinamicamente usando eval
codigo = <<-RUBY
  def preco_com_imposto
    @preco * 1.1
  end
RUBY

Produto.class_eval(codigo)

# Singleton methods
produto = Produto.new
produto.nome = "Notebook"
produto.preco = 5000.00

# Adicionando método apenas para esta instância
def produto.desconto_especial
  @preco * 0.8
end

puts "Preço com imposto: #{produto.preco_com_imposto}"
puts "Preço com desconto especial: #{produto.desconto_especial}"

# Usando send para chamar métodos dinamicamente
metodo = "preco_com_imposto"
puts "Chamando #{metodo}: #{produto.send(metodo)}"

# Definindo atributos dinamicamente
class Configuracao
  def self.definir_configuracao(nome, valor)
    define_method(nome) do
      valor
    end
  end
end

config = Configuracao.new
Configuracao.definir_configuracao(:versao, "1.0.0")
Configuracao.definir_configuracao(:ambiente, "desenvolvimento")

puts "Versão: #{config.versao}"
puts "Ambiente: #{config.ambiente}" 