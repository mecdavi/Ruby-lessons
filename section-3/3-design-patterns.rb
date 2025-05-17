# Padrões de Projeto em Ruby

# Singleton Pattern
puts "=== Singleton Pattern ==="
class Configuracao
  include Singleton

  def initialize
    @config = {
      ambiente: "desenvolvimento",
      porta: 3000,
      debug: true
    }
  end

  def obter(chave)
    @config[chave]
  end

  def definir(chave, valor)
    @config[chave] = valor
  end
end

# Usando o Singleton
config1 = Configuracao.instance
config2 = Configuracao.instance

puts "São a mesma instância? #{config1 == config2}"
config1.definir(:porta, 4000)
puts "Porta em config2: #{config2.obter(:porta)}"

# Factory Pattern
puts "\n=== Factory Pattern ==="
class Veiculo
  def initialize(modelo)
    @modelo = modelo
  end
end

class Carro < Veiculo
  def dirigir
    "Dirigindo #{@modelo}"
  end
end

class Moto < Veiculo
  def pilotar
    "Pilotando #{@modelo}"
  end
end

class VeiculoFactory
  def self.criar(tipo, modelo)
    case tipo
    when :carro
      Carro.new(modelo)
    when :moto
      Moto.new(modelo)
    else
      raise "Tipo de veículo desconhecido"
    end
  end
end

# Usando a Factory
carro = VeiculoFactory.criar(:carro, "Fusca")
moto = VeiculoFactory.criar(:moto, "Honda")

puts carro.dirigir
puts moto.pilotar

# Observer Pattern
puts "\n=== Observer Pattern ==="
module Observable
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end
end

class EstacaoMeteorologica
  include Observable

  attr_reader :temperatura, :umidade

  def atualizar_medicoes(temperatura, umidade)
    @temperatura = temperatura
    @umidade = umidade
    notify_observers
  end
end

class DisplayTemperatura
  def update(estacao)
    puts "Temperatura atual: #{estacao.temperatura}°C"
  end
end

class DisplayUmidade
  def update(estacao)
    puts "Umidade atual: #{estacao.umidade}%"
  end
end

# Usando o Observer
estacao = EstacaoMeteorologica.new
estacao.add_observer(DisplayTemperatura.new)
estacao.add_observer(DisplayUmidade.new)

estacao.atualizar_medicoes(25, 60)

# Strategy Pattern
puts "\n=== Strategy Pattern ==="
class Compressor
  def comprimir(arquivo)
    raise NotImplementedError
  end
end

class CompressorZIP < Compressor
  def comprimir(arquivo)
    "Comprimindo #{arquivo} em ZIP"
  end
end

class CompressorRAR < Compressor
  def comprimir(arquivo)
    "Comprimindo #{arquivo} em RAR"
  end
end

class GerenciadorArquivos
  def initialize(compressor)
    @compressor = compressor
  end

  def comprimir_arquivo(arquivo)
    @compressor.comprimir(arquivo)
  end
end

# Usando o Strategy
gerenciador = GerenciadorArquivos.new(CompressorZIP.new)
puts gerenciador.comprimir_arquivo("documento.txt")

gerenciador = GerenciadorArquivos.new(CompressorRAR.new)
puts gerenciador.comprimir_arquivo("documento.txt")

# Decorator Pattern
puts "\n=== Decorator Pattern ==="
class Cafe
  def custo
    5.0
  end

  def descricao
    "Café simples"
  end
end

class DecoradorCafe
  def initialize(cafe)
    @cafe = cafe
  end

  def custo
    @cafe.custo
  end

  def descricao
    @cafe.descricao
  end
end

class Leite < DecoradorCafe
  def custo
    @cafe.custo + 2.0
  end

  def descricao
    "#{@cafe.descricao} com leite"
  end
end

class Chocolate < DecoradorCafe
  def custo
    @cafe.custo + 3.0
  end

  def descricao
    "#{@cafe.descricao} com chocolate"
  end
end

# Usando o Decorator
cafe = Cafe.new
cafe_com_leite = Leite.new(cafe)
cafe_com_leite_e_chocolate = Chocolate.new(cafe_com_leite)

puts "#{cafe_com_leite_e_chocolate.descricao}: R$ #{cafe_com_leite_e_chocolate.custo}"

# Command Pattern
puts "\n=== Command Pattern ==="
class Comando
  def executar
    raise NotImplementedError
  end
end

class LigarLuz < Comando
  def initialize(luz)
    @luz = luz
  end

  def executar
    @luz.ligar
  end
end

class DesligarLuz < Comando
  def initialize(luz)
    @luz = luz
  end

  def executar
    @luz.desligar
  end
end

class Luz
  def ligar
    "Luz ligada"
  end

  def desligar
    "Luz desligada"
  end
end

class ControleRemoto
  def initialize
    @comandos = {}
  end

  def registrar_comando(botao, comando)
    @comandos[botao] = comando
  end

  def pressionar_botao(botao)
    @comandos[botao].executar if @comandos[botao]
  end
end

# Usando o Command
luz = Luz.new
controle = ControleRemoto.new

controle.registrar_comando(:ligar, LigarLuz.new(luz))
controle.registrar_comando(:desligar, DesligarLuz.new(luz))

puts controle.pressionar_botao(:ligar)
puts controle.pressionar_botao(:desligar) 