class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings

  after_save :update_published_tags

  private

  def update_published_tags
    UpdatePublishedTagsJob.perform_now
  end
end
