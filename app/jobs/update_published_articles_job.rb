class UpdatePublishedArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.cache.write('published_articles', Article.published)
    Rails.cache.write('unpublished_articles', Article.unpublished)
  end
end
