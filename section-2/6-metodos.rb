# Métodos e Funções em Ruby

# Método simples
def saudacao
  puts "Olá, mundo!"
end

# Método com parâmetros
def soma(a, b)
  return a + b
end

# Método com parâmetros opcionais
def cumprimentar(nome = "Visitante")
  puts "Olá, #{nome}!"
end

# Método com múltiplos parâmetros
def multiplicar(*numeros)
  resultado = 1
  numeros.each do |num|
    resultado *= num
  end
  return resultado
end

# Chamando os métodos
saudacao
puts "Soma: #{soma(5, 3)}"
cumprimentar("João")
cumprimentar
puts "Multiplicação: #{multiplicar(2, 3, 4)}"

# Método com bloco
def executar_com_bloco
  puts "Início do método"
    # yield executa algum trecho que é mandado para a funcao, if block_given? verifica se o bloco foi passado
  yield if block_given?
  puts "Fim do método"
end

def execucacao_yield
  puts "Início"
  yield if block_given?
  puts "Fim"
end 

execucacao_yield {puts soma(2, 3)}


# Usando o método com bloco
executar_com_bloco do
  puts "Este é um bloco de código!"
end 