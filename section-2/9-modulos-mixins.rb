# Módulos e Mixins em Ruby

# Definindo um módulo
module Calculadora
  def somar(a, b)
    a + b
  end

  def subtrair(a, b)
    a - b
  end

  def multiplicar(a, b)
    a * b
  end

  def dividir(a, b)
    a / b
  end
end

# Módulo para formatação
module Formatador
  def formatar_moeda(valor)
    "R$ #{valor.round(2)}"
  end

  def formatar_data(data)
    data.strftime("%d/%m/%Y")
  end
end

# Classe usando os módulos como mixins
class Produto
  include Calculadora
  include Formatador

  attr_accessor :nome, :preco, :data_fabricacao

  def initialize(nome, preco, data_fabricacao)
    @nome = nome
    @preco = preco
    @data_fabricacao = data_fabricacao
  end

  def preco_com_desconto(desconto)
    valor_descontado = subtrair(@preco, multiplicar(@preco, desconto))
    formatar_moeda(valor_descontado)
  end
end

# Usando a classe com os mixins
produto = Produto.new("Notebook", 5000.00, Date.today)

puts "Produto: #{produto.nome}"
puts "Preço: #{produto.formatar_moeda(produto.preco)}"
puts "Data de fabricação: #{produto.formatar_data(produto.data_fabricacao)}"
puts "Preço com 10% de desconto: #{produto.preco_com_desconto(0.1)}"

# Namespace com módulos
module Vendas
  class Cliente
    def initialize(nome)
      @nome = nome
    end
  end

  class Pedido
    def initialize(cliente)
      @cliente = cliente
    end
  end
end

# Usando classes dentro do namespace
cliente = Vendas::Cliente.new("João")
pedido = Vendas::Pedido.new(cliente) 