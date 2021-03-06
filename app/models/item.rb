class Item < ApplicationRecord
  belongs_to :user
  belongs_to :saler, class_name:"User", optional: true
  belongs_to :buyer, class_name:"User", optional: true
  belongs_to :large_category
  belongs_to :medium_category
  belongs_to :small_category
  belongs_to :bland, optional: true
  has_many :images, dependent: :delete_all
  accepts_nested_attributes_for :images
  validates :item_name, presence: true,length: { maximum: 40 }
  validates :description, length: { maximum: 1000 } ,presence: true
  validates :size, presence: true
  validates :condition, presence: true
  validates :charge_method, presence: true
  validates :prefecture, presence: true
  validates :handling_time, presence: true
  validates :price,presence: true
  validates :delivery_method, presence: true
  validates :price,numericality:{ greater_than: 299, less_than: 10000000}, presence: true
  enum prefecture: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7, 茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14, 新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20, 岐阜県:21,静岡県:22,愛知県:23,三重県:24, 滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30, 鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35, 徳島県:36,香川県:37,愛媛県:38,高知県:39, 福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
  enum status: {displayed: 0, shipped: 1, received: 2 ,trading: 3, stopped: 4}
    scope :be_sold, -> { where.not(buyer_id: nil) }
    scope :be_bought, -> (user_id) { where("buyer_id = ?", user_id) }
    scope :be_indexed, ->{ where.not(status: :stopped).where.not(status: :received) }
end
