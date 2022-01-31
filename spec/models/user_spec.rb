require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'user saved without error' do
      @user = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test")
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end

    context 'Password' do
      it 'password and password_confirmation should be present' do
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "", password_confirmation: "")
        expect(@user_1.errors.full_messages).to match( ["Password can't be blank", "Password confirmation can't be blank", "Password confirmation is too short (minimum is 2 characters)"])
      end
      it 'password and password_confirmation should match each other' do
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test1")
        expect(@user_1.errors.full_messages).to match(["Password confirmation doesn't match Password"])
      end
      it 'password should be between 2-20 characters' do
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "t", password_confirmation: "t")
        expect(@user_1.errors.full_messages).to include ("Password confirmation is too short (minimum is 2 characters)")
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "1234567890123456789012", password_confirmation: "1234567890123456789012")
        expect(@user_1.errors.full_messages).to include ("Password confirmation is too long (maximum is 20 characters)")
      end
    end
    context 'Email' do
      it 'should be present' do
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "", password: "test", password_confirmation: "test")
        expect(@user_1.errors.full_messages).to match(["Email can't be blank"])
      end
      it 'should not be case-sensitive' do
        @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test")
        @user_1.save
        @user_2 = User.create(first_name: "Cust", last_name: "Tomer", email: "A@B.C", password: "test", password_confirmation: "test")
        expect(@user_2.errors.full_messages).to match(["Email has already been taken"])
      end
    end
    context 'Name' do
      it 'firstname should be present' do
        @user_1 = User.create(first_name: "", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test")
        expect(@user_1.errors.full_messages).to match(["First name can't be blank"])
      end
      it 'lastname should be present' do
        @user_1 = User.create(first_name: "Cus", last_name: "", email: "a@b.c", password: "test", password_confirmation: "test")
        expect(@user_1.errors.full_messages).to match(["Last name can't be blank"])
      end
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'valid user can log in without error' do
      @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test")
      @user_1.save
      @user_2 = User.authenticate_with_credentials("a@b.c", "test")
      expect(@user_2).to eq(@user_1)
    end

    it 'invalid user cannot log in' do
      @user_3 = User.create(first_name: "Cust1", last_name: "Tomer1", email: "a@b.d", password: "test", password_confirmation: "test")
      @user_3.save
      @user_2 = User.authenticate_with_credentials("a@b.c", "test")
      expect(@user_2).to be nil
    end

    it 'email with spaces only before and after the main text can still log in' do
      @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "a@b.c", password: "test", password_confirmation: "test")
      @user_1.save
      @user_2 = User.authenticate_with_credentials("  a@b.c  ", "test")
      expect(@user_2).to eq(@user_1)
    end

    it 'email with wrong case but same word can still log in' do
      @user_1 = User.create(first_name: "Cust", last_name: "Tomer", email: "A@b.c", password: "test", password_confirmation: "test")
      @user_1.save
      @user_2 = User.authenticate_with_credentials("A@B.C", "test")
      expect(@user_2).to eq(@user_1)
    end
  end
end
