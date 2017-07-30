class Comment < ApplicationRecord
  belongs_to :post
  has_many :sub_comments, dependent: :destroy
end
