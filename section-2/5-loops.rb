# Loops e Iterações em Ruby

# For loop
puts "For loop:"
for i in 1..5
  puts "Número: #{i}"
end

# While loop
puts "\nWhile loop:"
contador = 1
while contador <= 5
  puts "Contador: #{contador}"
  contador += 1
end

# Until loop
puts "\nUntil loop:"
numero = 1
until numero > 5
  puts "Número: #{numero}"
  numero += 1
end

# Times
puts "\nTimes:"
5.times do |i|
  puts "Iteração #{i + 1}"
end

# Each com array
puts "\nEach com array:"
frutas = ["maçã", "banana", "laranja"]
frutas.each do |fruta|
  puts "Fruta: #{fruta}"
end

# Each com range
puts "\nEach com range:"
(1..5).each do |num|
  puts "Número: #{num}"
end 