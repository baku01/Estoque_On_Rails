require 'faker'

# Criando usuários
10.times do
  Usuario.create!(
    nome: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 10),
    perfil: rand(0..1),
    status: rand(0..1)
  )
end

# Criando grupos
10.times do
  Grupo.create!(
    nome: Faker::Commerce.department(max: 1, fixed_amount: true),
    status: rand(0..1)
  )
end

# Criando estoques
10.times do
  Estoque.create!(
    descricao: Faker::Lorem.sentence,
    unidade: rand(0..100),
    tipo: rand(0..1),
    grupo_id: Grupo.pluck(:id).sample
  )
end

# Criando entradas
10.times do
  Entrada.create!(
    data: Faker::Date.between(from: '2020-01-01', to: '2022-12-31'),
    documento: Faker::Number.number(digits: 10),
    numero: Faker::Number.number(digits: 10),
    quantidade: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    preco_unitario: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    preco_total: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    observacoes: Faker::Lorem.sentence,
    estoque_id: Estoque.pluck(:id).sample
  )
end

# Criando requisicaos
10.times do
  Requisicao.create!(
    tipo: rand(0..1),
    data: Faker::Date.between(from: '2020-01-01', to: '2022-12-31'),
    numero: Faker::Number.number(digits: 10),
    setor: rand(0..1),
    quantidade: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    custo_medio: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    custo_total: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    observacoes: Faker::Lorem.sentence,
    estoque_id: Estoque.pluck(:id).sample
  )
end

Usuario.create(nome: 'Usuário 1', perfil: 0, status: 0, email: 'usuario1@example.com', password: 'password123')