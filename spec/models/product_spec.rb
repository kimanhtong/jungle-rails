require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before do
      @category_init = Category.create(name: "Category")
      @category_init.save
      @product_init = Product.create(name: "Product", description: "Swiss made", image:"electronics3.jpg", price_cents: 100, quantity: 3, category_id: @category_init.id)
      @product_init.save
      expect(@product_init.errors.full_messages).to be_empty
    end

    it 'name should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(description: "Swiss made", image:"electronics3.jpg", price_cents: 100, quantity: 3, category_id: @category.id)
      expect(@product.errors.full_messages).to match(["Name can't be blank"])
    end
    it 'price should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", quantity: 3, category_id: @category.id)
      expect(@product.errors.full_messages).to match(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end
    it 'quantity should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", price_cents: 100, category_id: @category.id)
      expect(@product.errors.full_messages).to match(["Quantity can't be blank"])
    end
    it 'category should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", price_cents: 100, quantity: 3)
      expect(@product.errors.full_messages).to match(["Category can't be blank"])
    end

  end
end
