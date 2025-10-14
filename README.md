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
| Column   | Type   | Options                |
| -------- | ------ | ---------------------- |
| name     | string | not null               |
| email    | string | not null, unique: true |
| password | string | not null               |

### Association
has many :items
has many :orders

## itemsテーブル
| Column    | Type    | Options                     |
| --------- | ------- | --------------------------- | 
| title     | string  | not null                    |
| category  | string  | not null                    |
| price     | integer | not null                    |
| user_id   | integer | not null, foreign_key: true |

### Association
belongs_to :user
has_one :order

## ordersテーブル
| Column     | Type     |  Options                    |
| ---------- | -------- | --------------------------- |
| item_id    | integer  | not null, foreign_key: true |
| user_id    | integer  | not null, foreign_key: true |
| address_id | integer  | not null, foreign_key: true |
| orderdate  | datetime | not null                    |
 
### Association
belongs_to :item
belongs_to :user
belongs_to :address

## addressesテーブル
|Column       | Type   | Options      |
| ----------- | ------ | ------------ |
| postal_code | string | not null     |
| prefecture  | string | not null     |
| city        | string | not null     |
| street      | string | not null     |
| building    | string | null可       |

### Association
has_one :order