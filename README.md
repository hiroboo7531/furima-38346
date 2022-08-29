
<!-- カラム名はハイフンだめ、単数形で書くこと -->
<!-- 半角英数というのはマイグレーションファイルに記載しない情報。バリデーションでやること -->
<!-- マイグレーションファイルにおける制約は
    null: falseの空はダメ
    UniQue: true  同じ文字列は二つとだめ
    t.references :カラム名,  foreign_key: true このモデルはカラム名と関係を持つよ、関係的に子の方に記載する
    くらいで考えとけばおけ、あとはバリデーションで縛る -->
  <!--has_oneは1対１の関係の時に使うがアソシエーションで使うのは親、それがないと子は機能しえない。子はbelongs_to  -->

# テーブル設計

## users テーブル

| Column                    | Type     | Options     |
| -------------------       | ------   | ----------- |
| nick_name                 | string   | null: false |
| email                     | string   | null: false, UniQue: true|
| encrypted_password        | string   | null: false |
| first_name                | string   | null: false  |
| family_name               | string   | null: false |
| first_name2               | string   | null: false  |
| family_name2              | string   | null: false  |
| birth_day                 | date     | null: false |
<!-- | birth_year                | integer   | null: false |
| birth_month               | integer   | null: false |
| birth_day                 | integer   | null: false | -->
<!-- 生年月日を保存するカラムは、型をdate型にすることで管理が簡潔になります。
date型は年、月、日を1つでまとめて指定して保存できるためです。
今回の場合ですと、年月日を一括で管理することでカラムの準備も最小限にできますので、
birth_day等の名前でカラムを１つにして、date型への変更をお願いいたします。 -->

### Association

- has_many :items
- has_many :purchases

### items テーブル

| Column       | Type         | Options                      |
| -----------  | ------------ | ---------------------------- |
| (photo)      |              | image magick等にて実装          |
| item_name    | string       | null: false   |
| explanation  | text         | null: false   |
| category_id  | integer       | null: false |
| condition_id | integer       | null: false |
| send_fee_id    | integer      | null: false |
| prefecture_id       | integer       | null: false |
| delivery_date_id| integer      | null: false |
| price        | integer      | null: false |
| user         | references   | null: false, foreign_key: true |
<!-- active_hashを用いたカラムの特徴は2点ございます：
①カラム名に_idが付与されること
active_hashを用いたカラムは、具体的な値ではなくid値（数値）を保存します。
この場合は以下のように、カラムに_idを付与しておくことで管理がしやすくなります。
②integer型を付与すること
id値（数値）を保存する際は、string型ではなく
integer型でカラムを作成すると管理しやすくなります。 -->


### Association

- belongs to :user
- has_one    :purchase


## purchases テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
<!-- | credit_card       | integer    | null: false,14~16桁                     |
| period_month      | integer  | null: false ,未来の日付|
| period_year       | integer  | null: false ,未来の日付|
| secure_cord       | integer  | null: false ,3~4桁| -->
<!-- クレジットカード情報はPAYJPという外部サイトを使用して管理を進めますので、カラムの準備は不要となります！ -->
<!-- クレジットカード情報をDBに保存することは、国際的な取り決めに反しています。 -->

| item              | references   | null: false, foreign_key: true |
| user              | references   | null: false, foreign_key: true |
| send_info       | references   | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user
- has_one :send_info

## send_infos テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
|postal_number     | string   | null: false |
| prefecture_id     | integer   | null: false |
| city              | string   | null: false |
| house_number      | string   | null: false |
| building_name     | string   | 
| phone             | string  | null: false |
<!-- phoneをintegerでやると先頭に０をつけた場合読み取られない -->

### Association

- belongs_to :purchase