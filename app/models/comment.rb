class Comment < ApplicationRecord
  has_one_attached :image

  belongs_to :customer
  belongs_to :item

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :star_count, -> { order(star: :desc) }

  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end
end
