FactoryBot.define do
  factory :item do

 
  item_name       {Faker::Base.regexify("[aあ]{40}")}
    # 40文字の`a``あ`からなる文字列

  explanation    {Faker::Base.regexify("[mizu水5]{1000}")}
    # 1,000文字の`mizu水5`からなる文字列

  category_id      {Faker::Number.between(from: 2, to: 11) }
  condition_id     {Faker::Number.between(from: 2, to: 6) }
  send_fee_id      {Faker::Number.between(from: 2, to: 3) }
  prefecture_id   {Faker::Number.between(from: 1, to: 47) }
  delivery_date_id{Faker::Number.between(from: 2, to: 4) } 
  price           {Faker::Number.between(from: 300, to: 9999999) }

  after(:build) do |item|
    item.image.attach(io: File.open('public/images/test.png'), filename: 'test_image.png')
  end

  # publicにディレクトリを作り、サンプル画像を入れておく
  # カピバラはrails に初めから入っているGem
  # afterメソッドは任意の処理の後に指定の処理を実行することができます。例えば、after(:build) とすることで、インスタンスがbuildされた後に指定の処理を実行するよ。
    
  end
end
