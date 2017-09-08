# Updates the cached list of published tags
class UpdatePublishedTagsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Grab only published articles
    @articles = Article.published

    # Generate tags on published files
    @tags = []

    @articles.each do |a|
      a.tag_list.map { |b| @tags << b }
    end
    Rails.cache.write('published_tags', @tags)
  end
end
