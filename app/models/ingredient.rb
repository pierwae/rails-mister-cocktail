class Ingredient < ApplicationRecord
  INGREDIENTS = Ingredient.all

  has_many :doses
  validates :name, presence: true, uniqueness: true
  before_destroy :can_be_destroyed?

  private

  def can_be_destroyed?
    errors.add(:base, 'cannot delete ingredient used by a cocktail') unless doses.count.zero?
    errors.blank?
  end
end
