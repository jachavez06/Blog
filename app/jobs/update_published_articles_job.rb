class UpdatePublishedArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.cache.write('published_articles', Article.published)
  end
end
