class DeliveryDate < ActiveHash::Base
  # モデルクラス名にハイフンを入れることはできない
  # 例で挙げるとモデル名は上も下も同じ意味になる、だがモデルクラス名はアンダーバーを使えないので使わないように変換してあげる必要がある
  # rails g model ModelSchedule  user_id:integer schedule:text
  # rails g model model_schedule  user_id:integer schedule:text
  self.data = [
    
    { id: 1, name: '---' },
    { id: 2, name: '1~2日で発送' },
    { id: 3, name: '2~3日で発送' },
    { id: 4, name: '4~7日で発送' }

  ]
  
  include ActiveHash::Associations
  has_many :items
  # itemモデルでbelongs_toのアソシエーションを組むので相手になるこちらはhas_many
end