FactoryBot.define do
  factory :book, class: ShoppingCart.book_class do
    title { Faker::Book.title }
    description { Faker::StarWars.wookiee_sentence }
    price { rand(5..300) }
    width { rand(5..30) }
    height { rand(5..30) }
    depth { rand(5..30) }
    publication_year { rand(1970..2018) }
    materials { Faker::StarWars.planet }
  end
end
