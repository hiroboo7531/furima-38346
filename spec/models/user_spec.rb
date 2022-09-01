require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe "ユーザー新規登録" do
    it 'nicknameが空では登録できない' do
      user = User.new(nick_name: '', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Nick name can't be blank")
    end
    it 'emailが空では登録できない' do 
      user = User.new(nick_name: 'ああああ', email: '', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
        user2 = User.create(nick_name: 'ああああ', email: 'test@example', password: 'b000000', password_confirmation: 'b000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' ) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
       
        user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )

        user.valid?
        binding.pry
        expect(user.errors.full_messages).to include("Email has already been taken")
    end
    it'メールアドレスは、@を含む必要があること' do
      user = User.new(nick_name: 'ああああ', email: 'testexample', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Email is invalid")
    end
    it'パスワードが必須であること' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: '', password_confirmation: '',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a0000', password_confirmation: 'a0000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは、半角英数字混合での入力が必須であること' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: '000000', password_confirmation: '000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'b000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it'お名前(全角)は、名字がそれぞれ必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'',first_name:'あああ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      expect(user.errors.full_messages).to include("Family name can't be blank" )
      # "Family name に全角文字を使用してください",もfull_messagesのエラー文に入るけど記載しなくて良い
    end

    it'お名前(全角)は、名前がそれぞれ必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      expect(user.errors.full_messages).to include( "First name can't be blank")
      # "First name に全角文字を使用してください",もfull_messagesのエラー文に入るけど記載しなくて良い
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'aaa',first_name:'aaa',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Family name に全角文字を使用してください", "First name に全角文字を使用してください")
    end
    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'あああ',  family_name2:'',first_name2:'', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Family name2 can't be blank", "Family name2 に全角カタカナを使用してください", "First name2 can't be blank", "First name2 に全角カタカナを使用してください")
    end
    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'あああ',  family_name2:'あ',first_name2:'あ', birth_day:'2019-09-01' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Family name2 に全角カタカナを使用してください", "First name2 に全角カタカナを使用してください")
    end
    it' 生年月日が必須であること。' do
      user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'' )
      user.valid?
      #  binding.pry
      expect(user.errors.full_messages).to include("Birth day can't be blank")
      
    end
    # includeの後にスペースは開けないこと
    # エラーメッセージ自体は複数入れられるが１つのテストにつき１つが綺麗なコード
    # テストのお題に対するエラー文がincludeの後に入っていればよい
    # bundle exec rspec spec/models/user_spec.rb
   
  end

end
