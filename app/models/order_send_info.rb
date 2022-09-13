class OrderSendInfo

  include ActiveModel::Model
  # フォームオブジェクトを使うなら必須
  attr_accessor :user_id, :item_id, :post_number,:prefecture_id,:city_ward,:address, :building_name, :phone, :token

  with_options presence: true do
    # orderモデルのバリデーション
    validates :user_id
    validates :item_id
    # send_infoモデルのバリデーション
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city_ward
    validates :address
    validates :phone, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
    # トークンのバリデーション
    validates :token
  end

  def save
   
    order = Order.create(user_id: user_id, item_id: item_id)
 # ストロングパラメーターでデータが運ばれ、それらが保存のタイミングで「order_id」が生成され、保存される。
    SendInfo.create(order_id: order.id, post_number: post_number, prefecture_id: prefecture_id, city_ward: city_ward, address: address, building_name: building_name, phone: phone)
  end
end
