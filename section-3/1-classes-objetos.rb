# Classes e Objetos em Ruby

# Classe básica
class Pessoa
  # Atributos de classe
  @@total_pessoas = 0

  # Atributos de instância
  attr_accessor :nome, :idade
  attr_reader :id

  # Construtor
  def initialize(nome, idade)
    @nome = nome
    @idade = idade
    @id = gerar_id
    @@total_pessoas += 1
  end

  # Método de instância
  def apresentar
    "Olá, meu nome é #{@nome} e tenho #{@idade} anos."
  end

  # Método de classe
  def self.total_pessoas
    @@total_pessoas
  end

  private

  def gerar_id
    rand(1000..9999)
  end
end

# Herança
class Funcionario < Pessoa
  attr_accessor :cargo, :salario

  def initialize(nome, idade, cargo, salario)
    super(nome, idade)
    @cargo = cargo
    @salario = salario
  end

  def apresentar
    "#{super} Trabalho como #{@cargo}."
  end

  def calcular_salario_anual
    @salario * 12
  end
end

# Usando as classes
puts "=== Criando objetos ==="
pessoa = Pessoa.new("João", 25)
puts pessoa.apresentar
puts "ID: #{pessoa.id}"

funcionario = Funcionario.new("Maria", 30, "Desenvolvedora", 5000)
puts funcionario.apresentar
puts "Salário anual: R$ #{funcionario.calcular_salario_anual}"

puts "\nTotal de pessoas: #{Pessoa.total_pessoas}"

# Encapsulamento
class ContaBancaria
  def initialize(titular, saldo_inicial)
    @titular = titular
    @saldo = saldo_inicial
  end

  def depositar(valor)
    @saldo += valor if valor > 0
  end

  def sacar(valor)
    if valor > 0 && valor <= @saldo
      @saldo -= valor
      true
    else
      false
    end
  end

  def saldo
    @saldo
  end
end

puts "\n=== Encapsulamento ==="
conta = ContaBancaria.new("João", 1000)
puts "Saldo inicial: R$ #{conta.saldo}"
conta.depositar(500)
puts "Saldo após depósito: R$ #{conta.saldo}"
if conta.sacar(200)
  puts "Saque realizado. Saldo: R$ #{conta.saldo}"
else
  puts "Saque não realizado"
end

# Polimorfismo
class Animal
  def fazer_som
    raise NotImplementedError, "Subclasses devem implementar este método"
  end
end

class Cachorro < Animal
  def fazer_som
    "Au au!"
  end
end

class Gato < Animal
  def fazer_som
    "Miau!"
  end
end

puts "\n=== Polimorfismo ==="
animais = [Cachorro.new, Gato.new]
animais.each do |animal|
  puts animal.fazer_som
end 