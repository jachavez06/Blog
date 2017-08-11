# Articles for the site.
class Article < ApplicationRecord

  # Body
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true

  # Meta-data
  @keyword_regex = /\A([a-z]+|[0-9]+)(,\s([a-z]+|[0-9]+))*\z/i
  validates :meta_data_title, presence: true,
                              uniqueness: { case_sensitive: false }
  validates :meta_data_description, presence: true
  validates :meta_data_keywords, presence: true,
                                 format: { with: @keyword_regex,
                                           message: 'Invalid keyword format.' },
                                 length: { minimum: 3 }

  after_create :update_slug
  before_update :assign_slug

  def to_param
    slug
  end

  def make_publishable(articles_params)
    assign_attributes(articles_params.merge(published: true,
                                            created_at: Time.zone.now,
                                            updated_at: Time.zone.now))
  end

  def make_unpublishable(articles_params)
    assign_attributes(articles_params.merge(published: false))
  end

    # Check if article exists by looking up slug. 
    # Returns article object if exists.
    def self.article_exists? (slug)
        Article.exists?(slug: slug)
    end

    # action to check if article is published
    def self.article_published? (article)
        article.published
    end

  private

  def assign_slug
    self.slug = title.parameterize
  end

  def update_slug
    update_attributes slug: assign_slug
  end
end
