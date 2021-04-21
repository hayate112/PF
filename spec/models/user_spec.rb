# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "Userモデルに関するテスト", type: :model do
  describe 'ユーザ登録に関するテスト' do
    it "姓、名、姓(カナ)、名(カナ)、ニックネーム、メールアドレス、郵便番号、住所、電場番号、パスワードがある場合有効である" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "姓が未入力の場合、無効である" do
      user = FactoryBot.build(:user, family_name: '')
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "名が未入力の場合、無効である" do
      user = FactoryBot.build(:user, name: '')
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "姓(カナ)が未入力の場合、無効である" do
      user = FactoryBot.build(:user, family_name_kana: '')
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    it "名(カナ)が未入力の場合、無効である" do
      user = FactoryBot.build(:user, name_kana: '')
      user.valid?
      expect(user.errors[:name_kana]).to include("can't be blank")
    end

    it "メールアドレスが未入力の場合、無効である" do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    
    it "メールアドレスが重複していたら登録できない" do 
      user1 = FactoryBot.create(:user)
      expect(FactoryBot.build(:user, email: user1.email)).to_not be_valid
    end 

    it "郵便番号が未入力の場合、無効である" do
      user = FactoryBot.build(:user, postal_code: '')
      user.valid?
      expect(user.errors[:postal_code]).to include("can't be blank")
    end

    it "住所1が未入力の場合、無効である" do
      user = FactoryBot.build(:user, prefectures: '')
      user.valid?
      expect(user.errors[:prefectures]).to include("can't be blank")
    end

    it "住所2が未入力の場合、無効である" do
      user = FactoryBot.build(:user, city: '')
      user.valid?
      expect(user.errors[:city]).to include("can't be blank")
    end

    it "電場番号が未入力の場合、無効である" do
      user = FactoryBot.build(:user, phone_number: '')
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "パスワードが未入力の場合、無効である" do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  
    it "パスワードと確認パスワードが異なる場合保存できない" do 
      expect(FactoryBot.build(:user,password:"password",password_confirmation: "passward")).to_not be_valid 
    end
  end
end