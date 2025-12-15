require 'rails_helper'

RSpec.describe OrderAddress, type: :model do

  before do
    @user = FactoryBot.build_stubbed(:user)
    @item = FactoryBot.build_stubbed(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品を購入できる' do
      it 'すべての条件を満たすとき商品を購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名は空白でも商品を購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品を購入できない' do
      it 'トークン（クレジット情報）が空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が、「3桁ハイフン4桁」の半角文字列を満たさない場合購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が---だと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '市町村区が空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと購入できない' do
        @order_address.address_line = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address line can't be blank")
      end
      it '電話番号が空だと購入できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号が9桁以下の場合購入できない' do
        @order_address.phone = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end
      it '電話番号が12桁以上の場合購入できない' do
        @order_address.phone = '123456789123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end
      it '電話番号が半角数値でない場合購入できない' do
        @order_address.phone = 'test'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end
      it 'userが紐づいていないと登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
