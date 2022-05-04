class Like < ApplicationRecord

  belongs_to :user
  belongs_to :tweet, counter_cache: true
  
  around_save :catch_uniqueness_exception_for_like

  private

  def catch_uniqueness_exception_for_like
    yield
  rescue ActiveRecord::RecordNotUnique
    self.errors.add(:user, :taken)
  end
end
