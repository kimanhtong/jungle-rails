require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do

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

  scenario "They see all product details" do
    # ACT
    visit root_path
    page.find('.product', match: :first).find('header').click

    # DEBUG / VERIFY
    expect(page).to have_css 'article.product-detail'
    save_screenshot
  end

end
