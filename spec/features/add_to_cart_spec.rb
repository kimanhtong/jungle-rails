require 'rails_helper'

RSpec.feature "Visitor adds a product to Cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The number in My Cart is displayed as 1" do
    # ACT
    visit root_path
    page.find('.product', match: :first).find_button('Add').click

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_link 'My Cart (1)', href:'/cart'
  end

end
