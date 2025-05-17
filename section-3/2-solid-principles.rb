# Princípios SOLID e Boas Práticas em Ruby

# Single Responsibility Principle (SRP)
# Cada classe deve ter apenas uma razão para mudar

# Exemplo de violação do SRP
class Usuario
  def initialize(nome, email)
    @nome = nome
    @email = email
  end

  def salvar
    # Salva no banco de dados
  end

  def enviar_email
    # Envia email
  end

  def gerar_relatorio
    # Gera relatório
  end
end

# Aplicando SRP
class Usuario
  def initialize(nome, email)
    @nome = nome
    @email = email
  end
end

class UsuarioRepository
  def salvar(usuario)
    # Salva no banco de dados
  end
end

class EmailService
  def enviar_email(usuario)
    # Envia email
  end
end

class RelatorioService
  def gerar_relatorio(usuario)
    # Gera relatório
  end
end

# Open/Closed Principle (OCP)
# Entidades devem estar abertas para extensão, mas fechadas para modificação

# Exemplo de violação do OCP
class CalculadoraDesconto
  def calcular_desconto(valor, tipo)
    case tipo
    when "normal"
      valor * 0.1
    when "vip"
      valor * 0.2
    end
  end
end

# Aplicando OCP
class Desconto
  def calcular(valor)
    raise NotImplementedError
  end
end

class DescontoNormal < Desconto
  def calcular(valor)
    valor * 0.1
  end
end

class DescontoVIP < Desconto
  def calcular(valor)
    valor * 0.2
  end
end

class CalculadoraDesconto
  def calcular_desconto(valor, desconto)
    desconto.calcular(valor)
  end
end

# Liskov Substitution Principle (LSP)
# Subtipos devem ser substituíveis por seus tipos base

class Ave
  def voar
    "Estou voando!"
  end
end

class Pinguim < Ave
  def voar
    raise "Pinguins não podem voar!"
  end
end

# Aplicando LSP
class Ave
  def voar
    "Estou voando!"
  end
end

class AveQueNaoVoa < Ave
  def voar
    "Não posso voar!"
  end
end

# Interface Segregation Principle (ISP)
# Muitas interfaces específicas são melhores que uma interface geral

# Exemplo de violação do ISP
module Trabalhador
  def trabalhar
    # Trabalha
  end

  def comer
    # Come
  end

  def dormir
    # Dorme
  end
end

# Aplicando ISP
module Trabalhador
  def trabalhar
    # Trabalha
  end
end

module SerVivo
  def comer
    # Come
  end

  def dormir
    # Dorme
  end
end

# Dependency Inversion Principle (DIP)
# Dependa de abstrações, não de implementações concretas

# Exemplo de violação do DIP
class Notificador
  def initialize
    @email_service = EmailService.new
  end

  def notificar(usuario)
    @email_service.enviar(usuario)
  end
end

# Aplicando DIP
class Notificador
  def initialize(servico_notificacao)
    @servico_notificacao = servico_notificacao
  end

  def notificar(usuario)
    @servico_notificacao.enviar(usuario)
  end
end

# Exemplo prático combinando princípios SOLID
class Pedido
  attr_reader :itens, :cliente

  def initialize(cliente)
    @cliente = cliente
    @itens = []
  end

  def adicionar_item(item)
    @itens << item
  end

  def total
    @itens.sum(&:preco)
  end
end

class PedidoRepository
  def salvar(pedido)
    # Salva pedido no banco de dados
  end
end

class NotificadorPedido
  def initialize(servico_notificacao)
    @servico_notificacao = servico_notificacao
  end

  def notificar_pedido_realizado(pedido)
    @servico_notificacao.enviar(
      pedido.cliente,
      "Seu pedido foi realizado com sucesso!"
    )
  end
end

class CalculadoraDesconto
  def initialize(estrategia_desconto)
    @estrategia_desconto = estrategia_desconto
  end

  def calcular_desconto(pedido)
    @estrategia_desconto.calcular(pedido.total)
  end
end

# Usando as classes
pedido = Pedido.new(Cliente.new("João"))
pedido.adicionar_item(Item.new("Produto 1", 100))
pedido.adicionar_item(Item.new("Produto 2", 200))

repository = PedidoRepository.new
notificador = NotificadorPedido.new(EmailService.new)
calculadora = CalculadoraDesconto.new(DescontoNormal.new)

repository.salvar(pedido)
notificador.notificar_pedido_realizado(pedido)
desconto = calculadora.calcular_desconto(pedido) 