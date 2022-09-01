class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates :nick_name, presence: true
  validates :email, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  # .freeze
  # １行目では、「英数混合でなければならない」という正規表現を VALID_PASSWORD_REGEXという変数に代入しています。
  # freezeメソッドを端的に言うと、オブジェクトをfreezeメソッドで凍結すれば、そのオブジェクトに対して破壊的メソッドが使えなくなることです
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります'}, allow_blank: true
  # validates :カラム名, format: { with: 正規表現 , message ‘エラーメッセージ’}
  validates :password, presence: true
  # allow_blank: true とすることで、validates :email, format: {with: VALID_EMAIL_REGEX} が、メールアドレス（email)の入力が空の時に実行されないようにします。
  # validatesを２つに分けることで、 allow_blank: true が validates :email, format: {with: VALID_EMAIL_REGEX} にかからないようにします。
  # エラーメッセージがたくさん出るのを防げる
# 補足  1行にもできる
# validates :email,presence: true,format: {with: VALID_EMAIL_REGEX, allow_blank: true}

with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
# with_options presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/, message: 'に全角文字を使用してください' } do
  # これだとダメ、『々』や『一』などの文字が姓芸の対象から外れてる
  # message:"ここにエラーの時に出るメッセージを記述する。"
  # 大文字の部分は囲まれているが、あそこを小文字にすると小文字の範囲が行けるようになる、全角指定だから全角！
  validates :family_name, presence: true 
  validates :first_name, presence: true
end
# /[a-z\d]{6,}/i    これはアルファベット（大小問わず）または数字が6文字以上含まれているかチェックするもの。

with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/u, message: 'に全角カタカナを使用してください' } do
  validates :family_name2, presence: true
  validates :first_name2, presence: true
end

# キモとなる部分は[ァ-ヴー]の部分ですが、この部分の意味としては
# ァ-ヴは、文字コードの「ァ」から「ヴ」までの全角カタカナを意味し、ーはまんま長音記号「ー」を意味しています。
# なお、全角カタカナの文字コードの順番としては、ァアィイゥウェエォオカガキギクグケゲ
  validates :birth_day, presence: true

  
  
  has_many :items
  has_many :purchases
end
