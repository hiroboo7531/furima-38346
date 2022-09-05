require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "出品機能" do
    context 'できる時' do
      it '必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存されること。' do
        expect(@item).to be_valid
        # 実行結果が緑色で表示されていれば成功
      end
  
    end
    context 'できない時' do
      it '商品画像を１枚もないとできない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it '商品名がないとできない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
    
      it '商品名が41文字以上だとできない' do
        @item.item_name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name is too long (maximum is 40 characters)"
      end

      it '商品の説明がないとできない' do
        @item.explanation = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation can't be blank"
      end

      it '商品の説明が1001文字だとできない' do
        @item.explanation = 'あ' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation is too long (maximum is 1000 characters)"
      end

      it 'カテゴリーの情報が---だとできない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が---だとできない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end

      it '配送料の負担が---だとできない' do
        @item.send_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Send fee can't be blank"
      end

      it '発送元の地域が---だとできない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '発送までの日数の情報が---だとできない' do
        @item.delivery_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery date can't be blank"
      end

      it '価格の情報がないとできない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      
      it '価格の情報が299だとできない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end

      it '価格の情報が10,000,000だとできない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end

      it '価格の情報が全角だとできない' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end

      it '価格の情報が数字以外だとできない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
      
      it 'userが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
# bundle exec rspec spec/models/item_spec.rb
    end
  end
end
