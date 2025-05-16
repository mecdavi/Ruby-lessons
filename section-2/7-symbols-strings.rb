# Symbols e Strings em Ruby

# Strings
puts "=== Strings ==="
nome = "João"
sobrenome = "Silva"
nome_completo = nome + " " + sobrenome
puts "Nome completo: #{nome_completo}"

# Interpolação de strings
idade = 25
puts "Meu nome é #{nome} e tenho #{idade} anos"

# Métodos de string
puts "Maiúsculas: #{nome.upcase}"
puts "Minúsculas: #{nome.downcase}"
puts "Capitalizado: #{nome.capitalize}"
puts "Tamanho: #{nome.length}"

# Symbols
puts "\n=== Symbols ==="
# Symbols são imutáveis e mais eficientes que strings
:status
:ativo
:inativo

# Usando symbols como chaves em hash
estado = {
  :nome => "São Paulo",
  :sigla => "SP"
}

# Sintaxe alternativa para symbols em hash
estado = {
  nome: "São Paulo",
  sigla: "SP"
}

puts "Estado: #{estado[:nome]} (#{estado[:sigla]})"

def fazer_algo(tipo)
  case tipo
  when :salvar
    puts "Salvando..."
  when :excluir
    puts "Excluindo..."
  end
end

fazer_algo(:salvar)


# Comparando strings e symbols
puts "\n=== Comparação ==="
string1 = "ruby"
string2 = "ruby"
symbol1 = :ruby
symbol2 = :ruby

puts "Strings iguais? #{string1 == string2}"
puts "Strings mesmo objeto? #{string1.object_id == string2.object_id}"
puts "Symbols iguais? #{symbol1 == symbol2}"
puts "Symbols mesmo objeto? #{symbol1.object_id == symbol2.object_id}" 