class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHashを用いて、belongs_toを設定するには、extend ActiveHash::Associations::ActiveRecordExtensionsと記述してmoduleを取り込む必要があります。
  validates :image             , presence: true

  validates :item_name        , presence: true
  validates :item_name        ,length: { maximum: 40 }

  validates :explanation      , presence: true
  validates :explanation      ,length: { maximum: 1000 }

  validates :category_id      , presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  # 「---」を選択して保存しようとすると、デフォルトのエラーメッセージでは「must be other than 0」と表示,ユーザーに伝わりづらいため、「can't be blank」というエラーメッセージがユーザーに表示されるよう設定しています。

  validates :condition_id     , presence: true
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}

  validates :send_fee_id      , presence: true
  validates :send_fee_id, numericality: { other_than: 1 , message: "can't be blank"}

  validates :prefecture_id    , presence: true
  #ジャンルの選択が「---」の時は保存できないようにする、other_thanコロン後の数字はidだよ
  validates :prefecture_id, numericality: { other_than: 0 , message: "can't be blank"}

  validates :delivery_date_id   , presence: true
  validates :delivery_date_id, numericality: { other_than: 1 , message: "can't be blank"}

  validates :price             , presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
             format: { with: /\A[0-9]+\z/ }
  

  belongs_to :user
  # has_one    :purchase
  
  has_one_attached :image

  belongs_to :prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_date
  belongs_to :send_fee
end

# オプション集
# :greater_than	指定された値よりも大きくなければならないことを指定
# :greater_than_or_equal_to	指定された値と等しいか、それよりも大きくなければならないことを指定
# :equal_to	指定された値と等しくなければならないことを指定
# :less_than	指定された値よりも小さくなければならないことを指定
# :less_than_or_equal_to	指定された値と等しいか、それよりも小さくなければならないことを指定
# :other_than	渡した値以外の値でなければならないことを指定
