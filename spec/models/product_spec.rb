require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'name should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(description: "Swiss made", image:"electronics3.jpg", price_cents: 100, quantity: 3, category_id: 0)
      expect(@product.errors.full_messages).to include ("Name can't be blank")
    end
    it 'price should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", quantity: 3, category_id: 0)
      expect(@product.errors.full_messages).to include ("Price can't be blank")
    end
    it 'quantity should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", category_id: 0)
      expect(@product.errors.full_messages).to include ("Quantity can't be blank")
    end
    it 'category should be present' do
      @category = Category.create(name: "Cust")
      @category.save
      @product = Product.create(name: "test", description: "Swiss made", image:"electronics3.jpg", quantity: 3)
      expect(@product.errors.full_messages).to include ("Category can't be blank")
    end

  end
end
