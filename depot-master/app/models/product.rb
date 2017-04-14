# encoding: utf-8
class Product < ActiveRecord::Base
  # Подключаем концерн для того, чтобы запись помечалась, как удаленная, а не удалялась. 
  # Только нужно добавить поле deleted_at в эту модель
  include Archivable
  include Loggable

  has_many :line_items
  has_many :orders, through: :line_items
  has_many :reviews, as: :reviewable

  # Позволяем через сущность Product создавать отзывы
  # Напр.: product.reviews.create author: 'Kenny', text: 'Hello'
  accepts_nested_attributes_for :reviews, reject_if: :all_blank, allow_destroy: true

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: {message: 'не может быть пустым'}
  validates :title, length: { in: 4..255 }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: /\.(gif|jpg|png)\z/i,
    message: "Изображение должно иметь расширение gif, jpg или png." }

  validates :terms_of_service, acceptance: true
  validates :description, length: {
    minimum: 3,
    maximum: 250,
    tokenizer: lambda { |str| str.split(/\s+/) },
    too_short: "минимум %{count} слов",
    too_long: "максимум %{count} слов"
  }
  
  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'существуют товарные позиции')
      return false
    end
  end
end
