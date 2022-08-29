
<!-- カラム名はハイフンだめ、単数形で書くこと -->
# テーブル設計

## users テーブル

| Column                    | Type     | Options     |
| -------------------       | ------   | ----------- |
| nick-name                 | string   | null: false |
| email                     | string   | null: false, UniQue, 半角英数|
| encrypted_password        | string   | null: false |
| first_name                | string   | null: false ,全角漢字ひらカタ |
| family_name               | string   | null: false ,全角漢字ひらカタ|
| first_name2               | string   | null: false ,全角カタ |
| family_name2              | string   | null: false , 全角カタ |
| birth_year                | integer   | null: false |
| birth_month               | integer   | null: false |
| birth_day                 | integer   | null: false |

### Association

- has_many :exhibits
- has_many :orders

## Exhibits テーブル

| Column       | Type         | Options                      |
| -----------  | ------------ | ---------------------------- |
| (photo)      |              | image magick等にて実装          |
| item_name    | string       | null: false ,40文字まで       |
| explanation  | text         | null: false                  |
| category     | string       | null: false, foreign_key: true |
| condition    | string       | null: false  |
| fee          | string       | null: false |
| area         | string       | null: false |
| delivery_date| string       | null: false |
| price        | integer       | null: false , 300~9,999,999円まで|
| user         | references   | null: false, foreign_key: true |


### Association

- belongs to :user
- belongs to :order


## orders テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| credit_card       | integer    | null: false,14~16桁                     |
| period_month      | integer  | null: false ,未来の日付|
| period_year       | integer  | null: false ,未来の日付|
| secure_cord       | integer  | null: false ,3~4桁|
| post_number       | string   | null: false, 半角英数 3桁ハイフン4桁|
| prefecture        | string   | null: false |
| city_ward         | string   | null: false |
| address           | string   | null: false |
| building_name     | string   | 
| phone             | integer  | null: false   |


### Association

- belongs_to :exhibit
- belongs_to :user