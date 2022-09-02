class SendFee < ActiveHash::Base
  # モデルクラス名にハイフンを入れることはできない
  # 例で挙げるとモデル名は上も下も同じ意味になる、だがモデルクラス名はアンダーバーを使えないので使わないように変換してあげる必要がある
  # rails g model ModelSchedule  user_id:integer schedule:text
  # rails g model model_schedule  user_id:integer schedule:text
  self.data = [
    
    { id: 1, name: '---' },
    { id: 2, name: '着払い(購入者負担)' },
    { id: 3, name: '送料込み(出品者負担)' }
   
  ]
  
  include ActiveHash::Associations
  has_many :items
  # itemモデルでbelongs_toのアソシエーションを組むので相手になるこちらはhas_many
end