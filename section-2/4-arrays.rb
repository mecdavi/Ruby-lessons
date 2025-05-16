# Arrays em Ruby
# Arrays são coleções ordenadas de objetos

# Criando arrays
numeros = [1, 2, 3, 4, 5]
frutas = ["maçã", "banana", "laranja"]
misturado = [1, "texto", 3.14, true]

# Acessando elementos
puts "Primeiro elemento: #{numeros[0]}"
puts "Último elemento: #{numeros[-1]}"

# Métodos comuns de array
puts "Tamanho do array: #{numeros.length}"
puts "Array inclui 3? #{numeros.include?(3)}"
puts "Array ordenado: #{numeros.sort}"
puts "Array reverso: #{numeros.reverse}"

# Adicionando elementos
numeros << 6
numeros.push(7)
puts "Array após adicionar elementos: #{numeros}"

# Removendo elementos
numeros.pop
numeros.delete_at(0)
puts "Array após remover elementos: #{numeros}" 