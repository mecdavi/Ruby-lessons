# Testes e Boas Práticas de Desenvolvimento em Ruby

# Exemplo de classe para testar
class Calculadora
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
    raise ArgumentError, "Divisão por zero não é permitida" if b.zero?
    a / b
  end
end

# Testes unitários com RSpec
require 'rspec'

RSpec.describe Calculadora do
  let(:calculadora) { Calculadora.new }

  describe '#somar' do
    it 'soma dois números positivos' do
      expect(calculadora.somar(2, 3)).to eq(5)
    end

    it 'soma números negativos' do
      expect(calculadora.somar(-2, -3)).to eq(-5)
    end
  end

  describe '#subtrair' do
    it 'subtrai dois números' do
      expect(calculadora.subtrair(5, 3)).to eq(2)
    end
  end

  describe '#multiplicar' do
    it 'multiplica dois números' do
      expect(calculadora.multiplicar(4, 3)).to eq(12)
    end
  end

  describe '#dividir' do
    it 'divide dois números' do
      expect(calculadora.dividir(10, 2)).to eq(5)
    end

    it 'lança erro ao dividir por zero' do
      expect { calculadora.dividir(10, 0) }.to raise_error(ArgumentError)
    end
  end
end

# Exemplo de classe com injeção de dependência
class Notificador
  def initialize(servico_email)
    @servico_email = servico_email
  end

  def notificar(usuario, mensagem)
    @servico_email.enviar(usuario.email, mensagem)
  end
end

# Mock e Stub em testes
RSpec.describe Notificador do
  let(:servico_email) { double('ServicoEmail') }
  let(:notificador) { Notificador.new(servico_email) }
  let(:usuario) { double('Usuario', email: 'teste@email.com') }

  it 'envia email para o usuário' do
    expect(servico_email).to receive(:enviar).with('teste@email.com', 'Olá!')
    notificador.notificar(usuario, 'Olá!')
  end
end

# Exemplo de classe com validações
class Usuario
  attr_accessor :nome, :email, :idade

  def initialize(nome, email, idade)
    @nome = nome
    @email = email
    @idade = idade
    validar!
  end

  private

  def validar!
    raise ArgumentError, "Nome não pode ser vazio" if @nome.nil? || @nome.empty?
    raise ArgumentError, "Email inválido" unless @email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    raise ArgumentError, "Idade deve ser maior que 0" if @idade <= 0
  end
end

# Testes de validação
RSpec.describe Usuario do
  it 'cria usuário com dados válidos' do
    expect { Usuario.new("João", "joao@email.com", 25) }.not_to raise_error
  end

  it 'rejeita nome vazio' do
    expect { Usuario.new("", "joao@email.com", 25) }.to raise_error(ArgumentError)
  end

  it 'rejeita email inválido' do
    expect { Usuario.new("João", "email_invalido", 25) }.to raise_error(ArgumentError)
  end

  it 'rejeita idade inválida' do
    expect { Usuario.new("João", "joao@email.com", 0) }.to raise_error(ArgumentError)
  end
end

# Exemplo de classe com tratamento de exceções
class Banco
  def initialize(saldo_inicial = 0)
    @saldo = saldo_inicial
  end

  def depositar(valor)
    raise ArgumentError, "Valor deve ser positivo" if valor <= 0
    @saldo += valor
  end

  def sacar(valor)
    raise ArgumentError, "Valor deve ser positivo" if valor <= 0
    raise ArgumentError, "Saldo insuficiente" if valor > @saldo
    @saldo -= valor
  end

  def saldo
    @saldo
  end
end

# Testes de exceções
RSpec.describe Banco do
  let(:banco) { Banco.new(1000) }

  describe '#depositar' do
    it 'aceita depósito válido' do
      banco.depositar(500)
      expect(banco.saldo).to eq(1500)
    end

    it 'rejeita depósito negativo' do
      expect { banco.depositar(-100) }.to raise_error(ArgumentError)
    end
  end

  describe '#sacar' do
    it 'aceita saque válido' do
      banco.sacar(500)
      expect(banco.saldo).to eq(500)
    end

    it 'rejeita saque maior que o saldo' do
      expect { banco.sacar(1500) }.to raise_error(ArgumentError)
    end

    it 'rejeita saque negativo' do
      expect { banco.sacar(-100) }.to raise_error(ArgumentError)
    end
  end
end

# Exemplo de classe com logging
require 'logger'

class ServicoProcessamento
  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
  end

  def processar(dados)
    @logger.info("Iniciando processamento")
    begin
      resultado = realizar_processamento(dados)
      @logger.info("Processamento concluído com sucesso")
      resultado
    rescue StandardError => e
      @logger.error("Erro no processamento: #{e.message}")
      raise
    end
  end

  private

  def realizar_processamento(dados)
    # Simulação de processamento
    sleep(1)
    "Processado: #{dados}"
  end
end

# Testes de logging
RSpec.describe ServicoProcessamento do
  let(:servico) { ServicoProcessamento.new }
  let(:logger) { instance_double(Logger) }

  before do
    allow(Logger).to receive(:new).and_return(logger)
    allow(logger).to receive(:info)
    allow(logger).to receive(:error)
  end

  it 'registra início e fim do processamento' do
    expect(logger).to receive(:info).with("Iniciando processamento")
    expect(logger).to receive(:info).with("Processamento concluído com sucesso")
    servico.processar("dados")
  end

  it 'registra erro quando ocorre exceção' do
    allow(servico).to receive(:realizar_processamento).and_raise(StandardError.new("Erro teste"))
    expect(logger).to receive(:error).with("Erro no processamento: Erro teste")
    expect { servico.processar("dados") }.to raise_error(StandardError)
  end
end 