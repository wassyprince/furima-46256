# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
| Column    | Type   | Options                   |
| --------- | ------ | ------------------------- |
| nickname  | string | null: false               |
| email     | string | null: false, unique: true |
| password  | string | null: false               |
| name      | string | null: false               |
| kana_name | string | null: false               |
| birthday  | date   | null: false               |

### Association
has many :items
has many :orders

## itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ | 
| image              | string     | null: false                    |
| title              | string     | null: false                    |
| description        | text       | null: false                    | 
| category           | string     | null: false                    |
| status             | string     | null: false                    |
| price              | integer    | null: false                    |
| shipping_fee_payer | string     | null: false                    |
| shipping_origin    | string     | null: false                    |
| shipping_days      | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
belongs_to :user
has_one :order

## ordersテーブル
| Column     | Type        |  Options                       |
| ---------- | ----------  | ------------------------------ |
| item       | references  | null: false, foreign_key: true |
| user       | references  | null: false, foreign_key: true |
 
### Association
belongs_to :item
belongs_to :user
has_one :address

## addressesテーブル
|Column       | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| postal_code | string     | null: false                   |
| prefecture  | string     | null: false                   |
| city        | string     | null: false                   |
| street      | string     | null: false                   |
| building    | string     | null: true                    |
| order       | references | null: false, foreign_key:true |

### Association
belongs_to :order