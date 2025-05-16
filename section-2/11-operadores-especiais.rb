# Operadores Especiais e Recursos Únicos do Ruby

# Operador de Navegação Segura (&.)
puts "=== Operador de Navegação Segura ==="
class Usuario
  attr_accessor :nome, :endereco
end

class Endereco
  attr_accessor :rua, :cidade
end

# Sem o operador de navegação segura
usuario = Usuario.new
if usuario && usuario.endereco && usuario.endereco.rua
  puts usuario.endereco.rua
end

# Com o operador de navegação segura
puts usuario&.endereco&.rua # Retorna nil sem erro

# Operador de Pipeline (|>)
puts "\n=== Operador de Pipeline ==="
# Em Ruby, podemos encadear métodos
texto = "  ruby é incrível  "
resultado = texto.strip.upcase.reverse
puts resultado

# Podemos fazer o mesmo com blocos
resultado = texto
  .strip
  .upcase
  .reverse
puts resultado

# Operador de Atribuição Condicional (||=)
puts "\n=== Operador de Atribuição Condicional ==="
class Cache
  def initialize
    @dados = {}
  end

  def obter(chave)
    @dados[chave] ||= calcular_valor(chave)
  end

  private

  def calcular_valor(chave)
    puts "Calculando valor para #{chave}"
    chave.upcase
  end
end

cache = Cache.new
puts cache.obter("teste") # Calcula e armazena
puts cache.obter("teste") # Usa o valor em cache

# Operador de Range (.. e ...)
puts "\n=== Operadores de Range ==="
# Range inclusivo (..)
(1..5).each { |n| print "#{n} " }
puts

# Range exclusivo (...)
(1...5).each { |n| print "#{n} " }
puts

# Operador de Splat (*)
puts "\n=== Operador Splat ==="
def somar(*numeros)
  numeros.sum
end

puts somar(1, 2, 3, 4, 5)

# Operador de Double Splat (**)
puts "\n=== Operador Double Splat ==="
def configurar(**opcoes)
  puts "Configurações: #{opcoes}"
end

configurar(porta: 3000, ambiente: "desenvolvimento", debug: true)

# Operador de Modificação (!)
puts "\n=== Operador de Modificação ==="
texto = "ruby"
puts texto.upcase    # Retorna nova string
puts texto          # String original não é modificada
puts texto.upcase!  # Modifica a string original
puts texto          # String original foi modificada

# Operador de Comparação Combinada (<=>)
puts "\n=== Operador de Comparação Combinada ==="
class Produto
  attr_accessor :nome, :preco

  def initialize(nome, preco)
    @nome = nome
    @preco = preco
  end

  def <=>(outro)
    @preco <=> outro.preco
  end
end

produtos = [
  Produto.new("Notebook", 5000),
  Produto.new("Smartphone", 2000),
  Produto.new("Tablet", 3000)
]

produtos.sort.each do |produto|
  puts "#{produto.nome}: R$ #{produto.preco}"
end 