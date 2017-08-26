# Articles for the site.
class Article < ApplicationRecord

  has_many :taggings
  has_many :tags, through: :taggings

  # Used when form is processed
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    if self.tags.present?
      to_return = '<span class="badge badge-pill badge-default">'
      tags = self.tags.map(&:name).join('</span><span class="badge badge-pill badge-default">')
      return to_return + tags + '</span>'
    else
      return ""
    end
  end
  def tags?
    if self.tags.present?
      return true
    else
      return false
    end 
  end
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
