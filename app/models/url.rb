# frozen_string_literal: true

class Url < ApplicationRecord
  validates :short_link, uniqueness: true
  validates :link, presence: true, uniqueness: true, url: true
  validates :stat, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_create :generate_short_link!

  private

  def generate_short_link!
    loop do
      str = SecureRandom.alphanumeric(5)
      break self.short_link = str if Url.where(short_link: str).empty?
    end
  end
end
