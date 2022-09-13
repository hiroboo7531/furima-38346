FactoryBot.define do
  factory :order_send_info do
    token         { 'tok_abcdefghijk00000000000000005' }
    post_number   { '123-4567' }
    prefecture_id { 2 }
    city_ward     { '横浜市緑区' }
    address       { '青山1-1-1' }
    building_name { '柳ビル103' }
    phone         { '09012345678' }
    
  end
end
