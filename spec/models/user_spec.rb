require 'rails_helper'
# rails g rspec:model userこれを使ってテストファイルは作成
RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
   context '新規登録できる時' do
    it '全ての項目が入力されていれば登録できる' do
      expect(@user).to be_valid
      # binding.pry
    end
   end
   context '新規登録ができない時' do
    it 'nicknameが空では登録できない' do
      @user.nick_name = ''  
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include "Nick name can't be blank"
    end
   
    it 'emailが空では登録できない' do 
      @user.email = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'メールアドレスが一意性であること' do
      
      @user.save
      user2 = FactoryBot.build(:user)
      user2.email = @user.email
      user2.valid?
      expect(user2.errors.full_messages).to include("Email has already been taken")
     end


    it'メールアドレスに@を含まない場合は登録できない' do
     @user.email = 'aaaaaa'  
     @user.valid?
     expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it'パスワードが空では登録できない' do
      @user.password = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードが6文字未満では登録できない' do
      @user.password = 'aaa1'  
      @user.password_confirmation = 'aaa1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'aaaaaaa'  
      @user.password_confirmation = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '1111111'  
      @user.password_confirmation = '1111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
    end
    it '全角文字を含むパスワードでは登録できない' do
      @user.password = '111111あ'  
      @user.password_confirmation = '111111あ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
    end
    it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
      @user.password = '1111111a'  
      @user.password_confirmation = '111111aa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '姓（全角）が空だと登録できない' do
      @user.family_name = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it '姓（全角）に半角文字が含まれていると登録できない' do
      @user.family_name = 'aaa'  
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    end
    it '名（全角）が空だと登録できない' do
      @user.first_name = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it '名（全角）に半角文字が含まれていると登録できない' do
      @user.first_name = 'aaa'  
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
    end
    it '姓（カナ）が空だと登録できない' do
      @user.family_name2 = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name2 can't be blank")
    end
    it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.family_name2 = 'あああ一５'  
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name2 に全角カタカナを使用してください")
    end
    it '名（カナ）が空だと登録できない' do
      @user.first_name2 = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("First name2 can't be blank")
    end
    it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.first_name2 = 'aaaあああ'  
      @user.valid?
      expect(@user.errors.full_messages).to include("First name2 に全角カタカナを使用してください")
    end
    it '生年月日が空だと登録できない' do
      @user.birth_day = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
    # テストコードのbinding.pryのコメントアウトは消すように
    # bundle exec rspec spec/models/user_spec.rb

 # includeの後にスペースは開けないこと
    # エラーメッセージ自体は複数入れられるが１つのテストにつき１つが綺麗なコード
    # テストのお題に対するエラー文がincludeの後に入っていればよい
    # bundle exec rspec spec/models/user_spec.rb
  # describe "ユーザー新規登録" do
  #   it 'nicknameが空では登録できない' do
  #     user = User.new(nick_name: '', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     # binding.pry
  #     expect(user.errors.full_messages).to include("Nick name can't be blank")
  #   end
  #   it 'emailが空では登録できない' do 
  #     user = User.new(nick_name: 'ああああ', email: '', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     # binding.pry
  #     expect(user.errors.full_messages).to include("Email can't be blank")
  #   end

  #   it 'メールアドレスが一意性であること' do
  #       user2 = User.create(nick_name: 'ああああ', email: 'test@example', password: 'b000000', password_confirmation: 'b000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' ) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
       
  #       user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )

  #       user.valid?
  #       # binding.pry
  #       expect(user.errors.full_messages).to include("Email has already been taken")
  #   end
  #   it'メールアドレスは、@を含む必要があること' do
  #     user = User.new(nick_name: 'ああああ', email: 'testexample', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Email is invalid")
  #   end
  #   it'パスワードが必須であること' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: '', password_confirmation: '',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Password can't be blank")
  #   end
  #   it 'パスワードは、6文字以上での入力が必須であること' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a0000', password_confirmation: 'a0000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  #   end
  #   it 'パスワードは、半角英数字混合での入力が必須であること' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: '000000', password_confirmation: '000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
  #   end
  #   it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'b000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
  #   end
  #   it'お名前(全角)は、名字がそれぞれ必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'',first_name:'あああ',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     expect(user.errors.full_messages).to include("Family name can't be blank" )
  #     # "Family name に全角文字を使用してください",もfull_messagesのエラー文に入るけど記載しなくて良い
  #   end

  #   it'お名前(全角)は、名前がそれぞれ必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     expect(user.errors.full_messages).to include( "First name can't be blank")
  #     # "First name に全角文字を使用してください",もfull_messagesのエラー文に入るけど記載しなくて良い
  #   end

  #   it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'aaa',first_name:'aaa',  family_name2:'ア',first_name2:'ア', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Family name に全角文字を使用してください", "First name に全角文字を使用してください")
  #   end
  #   it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'あああ',  family_name2:'',first_name2:'', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Family name2 can't be blank", "Family name2 に全角カタカナを使用してください", "First name2 can't be blank", "First name2 に全角カタカナを使用してください")
  #   end
  #   it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'あああ',first_name:'あああ',  family_name2:'あ',first_name2:'あ', birth_day:'2019-09-01' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Family name2 に全角カタカナを使用してください", "First name2 に全角カタカナを使用してください")
  #   end
  #   it' 生年月日が必須であること。' do
  #     user = User.new(nick_name: 'ああああ', email: 'test@example', password: 'a000000', password_confirmation: 'a000000',family_name:'ああ',first_name:'あ',  family_name2:'ア',first_name2:'ア', birth_day:'' )
  #     user.valid?
  #     #  binding.pry
  #     expect(user.errors.full_messages).to include("Birth day can't be blank")
      
  #   end
    # includeの後にスペースは開けないこと
    # エラーメッセージ自体は複数入れられるが１つのテストにつき１つが綺麗なコード
    # テストのお題に対するエラー文がincludeの後に入っていればよい
    # bundle exec rspec spec/models/user_spec.rb
    end 
  end

end
