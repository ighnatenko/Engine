ShoppingCart::Engine.load_seed

ShoppingCart::Delivery.destroy_all
ShoppingCart::Coupon.destroy_all
User.destroy_all
Book.destroy_all

3.times do |index|
  ShoppingCart::Delivery.create(title: 'Delivery - test', price: index * 5 + 5,
                                days: '3 to 5 days', active: true)
end

5.times do |index|
  ShoppingCart::Coupon.create!(code: "code-#{index}", discount: index + 3)
end

2.times do
  Book.create(
    title: Faker::Book.title,
    description: "#{Faker::StarWars.wookiee_sentence} We pore through hundreds.",
    price: rand(5..300),
    width: rand(5..30),
    height: rand(5..30),
    depth: rand(5..30),
    publication_year: rand(1970..2018),
    materials: Faker::StarWars.planet
  )
end

User.create(email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password',
            admin: true)
