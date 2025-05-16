# Recursos Avançados do Ruby

# Refinamentos (Refinements)
puts "=== Refinamentos ==="
module StringRefinements
  refine String do
    def to_slug
      self.downcase.gsub(/\s+/, '-').gsub(/[^a-z0-9-]/, '')
    end
  end
end

# Usando refinamentos
class Artigo
  using StringRefinements

  def initialize(titulo)
    @titulo = titulo
  end

  def slug
    @titulo.to_slug
  end
end

artigo = Artigo.new("Ruby é Incrível!")
puts "Slug: #{artigo.slug}"

# Pattern Matching
puts "\n=== Pattern Matching ==="
# Pattern Matching com case
def analisar_pessoa(pessoa)
  case pessoa
  in {nome: String => nome, idade: Integer => idade} if idade >= 18
    puts "#{nome} é maior de idade"
  in {nome: String => nome, idade: Integer => idade}
    puts "#{nome} é menor de idade"
  in {nome: String => nome}
    puts "#{nome} não tem idade definida"
  else
    puts "Dados inválidos"
  end
end

analisar_pessoa({nome: "João", idade: 25})
analisar_pessoa({nome: "Maria", idade: 15})
analisar_pessoa({nome: "Pedro"})

# Pattern Matching com arrays
def analisar_array(array)
  case array
  in [first, *rest] if first > 0
    puts "Primeiro elemento positivo: #{first}"
    puts "Resto: #{rest}"
  in [first, *rest]
    puts "Primeiro elemento não positivo: #{first}"
    puts "Resto: #{rest}"
  in []
    puts "Array vazio"
  end
end

analisar_array([1, 2, 3, 4])
analisar_array([-1, 2, 3])
analisar_array([])

# Pattern Matching com classes
class Ponto
  def initialize(x, y)
    @x = x
    @y = y
  end

  def deconstruct
    [@x, @y]
  end

  def deconstruct_keys(keys)
    {x: @x, y: @y}
  end
end

def analisar_ponto(ponto)
  case ponto
  in Ponto[x, y] if x == y
    puts "Ponto na diagonal: (#{x}, #{y})"
  in Ponto[x, y]
    puts "Ponto: (#{x}, #{y})"
  end
end

analisar_ponto(Ponto.new(5, 5))
analisar_ponto(Ponto.new(3, 4))

# Pattern Matching com guardas
def analisar_numero(numero)
  case numero
  in Integer => n if n > 0
    puts "#{n} é positivo"
  in Integer => n if n < 0
    puts "#{n} é negativo"
  in Integer => n
    puts "#{n} é zero"
  in Float => f
    puts "#{f} é um número decimal"
  else
    puts "Não é um número"
  end
end

analisar_numero(5)
analisar_numero(-3)
analisar_numero(0)
analisar_numero(3.14)
analisar_numero("texto")

# Pattern Matching com pin operator (^)
def analisar_coordenadas(x, y)
  case [x, y]
  in [^x, ^x]
    puts "Ponto na diagonal principal"
  in [^x, _]
    puts "Ponto na mesma linha"
  in [_, ^y]
    puts "Ponto na mesma coluna"
  else
    puts "Ponto em outra posição"
  end
end

analisar_coordenadas(5, 5)
analisar_coordenadas(5, 3)
analisar_coordenadas(2, 5)
analisar_coordenadas(1, 2) 