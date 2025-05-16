# Blocks e Procs em Ruby

# Blocks
puts "=== Blocks ==="
# Block simples
5.times { puts "Olá!" }

# Block com parâmetro
5.times do |i|
  puts "Número: #{i}"
end

# Block com array
frutas = ["maçã", "banana", "laranja"]
frutas.each do |fruta|
  puts "Fruta: #{fruta}"
end

# Método com block
def executar_block
  puts "Início"
  yield
  puts "Fim"
end

executar_block do
  puts "Executando o block!"
end

# Procs
puts "\n=== Procs ==="
# Criando um Proc
soma = Proc.new { |a, b| a + b }
multiplicacao = Proc.new { |a, b| a * b }

# Usando o Proc
puts "Soma: #{soma.call(5, 3)}"
puts "Multiplicação: #{multiplicacao.call(5, 3)}"

# Proc com método
def executar_proc(proc)
  proc.call(5, 3)
end

puts "Resultado: #{executar_proc(soma)}"

# Lambda
puts "\n=== Lambda ==="
# Criando um Lambda
dobro = lambda { |x| x * 2 }
triplo = ->(x) { x * 3 }

# Usando o Lambda
puts "Dobro de 5: #{dobro.call(5)}"
puts "Triplo de 5: #{triplo.call(5)}"

# Diferença entre Proc e Lambda
def testar_proc
  proc = Proc.new { return "Retorno do Proc" }
  proc.call
  return "Retorno do método"
end

def testar_lambda
  lambda = lambda { return "Retorno do Lambda" }
  lambda.call
  return "Retorno do método"
end

puts "Teste Proc: #{testar_proc}"
puts "Teste Lambda: #{testar_lambda}" 