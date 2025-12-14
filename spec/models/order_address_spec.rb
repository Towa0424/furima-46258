require 'rails_helper'

RSpec.describe OrderAddress, type: :model do

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品を購入できる' do
      it 'すべての条件を満たすとき商品を購入できる' do
        expect(@order_address).to be_valid
      end
      it '' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品を購入できない' do
      it 'トークン（クレジット情報）が空だと出品できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと出品できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が、「3桁ハイフン4桁」の半角文字列を満たさない場合出品できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end
      it '市町村区が空だと出品できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと出品できない' do
        @order_address.address_line = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address line can't be blank")
      end
      it '電話番号が空だと出品できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号が0桁以上11桁以内の半角数値でない場合出品できない' do
        @order_address.phone = '123-1234-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end
    end
  end
end
