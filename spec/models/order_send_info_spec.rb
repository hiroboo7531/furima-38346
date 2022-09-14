require 'rails_helper'

RSpec.describe OrderSendInfo, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_send_info = FactoryBot.build(:order_send_info, user_id: user.id, item_id: item.id)
    sleep 0.1
    # tips
    # max_allowed_packetの最大値を変更することで解決できる
    # MySQLのクライアントとサーバー間の通信のパケットサイズの最大値の設定で、1回のリクエストでここの大きさより大きいリクエストは送り込無ことができない。
    # sleep 指定した秒数と事前に記述しておくことで、インスタンス変数を生成するたびに指定した秒数、処理を停止するというもの
  end

  describe '商品購入情報の保存' do
    context '商品購入情報を保存できるとき' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@order_send_info).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @order_send_info.building_name = ''
        expect(@order_send_info).to be_valid
      end
    end

    context '商品購入情報を保存できないとき' do
      it 'tokenが空では保存できない' do
        @order_send_info.token = ' '
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_numberが空では保存できない' do
        @order_send_info.post_number = ''
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Post number can't be blank")
      end
      it 'prefecture_idが空では保存できない' do
        @order_send_info.prefecture_id = ''
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'city_wardが空では保存できない' do
        @order_send_info.city_ward = ''
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("City ward can't be blank")
      end
      it 'addressが空では保存できない' do
        @order_send_info.address = ''
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空では保存できない' do
        @order_send_info.phone = ''
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Phone can't be blank")
      end
      it 'post_numberはハイフンがないと保存できない' do
        @order_send_info.post_number = '1234567'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it 'post_numberは半角英数混合では保存できない' do
        @order_send_info.post_number = '123-abcd'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it 'post_numberは全角では保存できない' do
        @order_send_info.post_number = '１２３-４５６７'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it 'prefecture_idは選択していないと保存できない' do
        @order_send_info.prefecture_id = 0
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'phoneは12桁の数字では保存できない' do
        @order_send_info.phone = '090123456789'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneは半角英数混合では保存できない' do
        @order_send_info.phone = 'abc123456789'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneは全角では保存できない' do
        @order_send_info.phone = '０９０１２３４５６７８'
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include('Phone is invalid')
      end
      it 'user_id（購入者）が空だと保存できない' do
        @order_send_info.user_id = ' '
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("User can't be blank")
      end
      it 'item_id（購入商品）が空だと保存できない' do
        @order_send_info.item_id = ' '
        @order_send_info.valid?
        expect(@order_send_info.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
