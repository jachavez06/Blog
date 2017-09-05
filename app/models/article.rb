# Articles for the site.
class Article < ApplicationRecord
  # Callbacks
  after_create :update_slug
  before_update :assign_slug

  # Enum
  enum state: %i[draft published]
  # Regex
  @keyword_regex = /\A([a-z]+|[0-9]+)(,\s([a-z]+|[0-9]+))*\z/i

  # Associations
  acts_as_taggable
  # VALIDATION
  # Draft
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true

  # Published
  with_options if: :published? do |article|
    article.validates :meta_data_title, presence: true,
                                        uniqueness: { case_sensitive: false }
    article.validates :meta_data_description, presence: true
    article.validates :meta_data_keywords,
                      presence: true,
                      format: { with: @keyword_regex,
                                message: 'Invalid keyword format.' },
                      length: { minimum: 3 }
  end

  # Checks that object has at least one tag 
  def tags?
    return false unless tags.present?
    true
  end

  # Used when form is processed
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def styled_tags
    to_return = '<span class="badge badge-pill badge-default">'
    tags = self.tags.map(&:name).join('</span><span class="badge badge-pill badge-default">')
    return to_return + tags + '</span>'
  end

  def to_param
    slug
  end

  def make_publishable(articles_params)
    assign_attributes(articles_params.merge(state: :published,
                                            created_at: Time.zone.now,
                                            updated_at: Time.zone.now))
  end

  def make_unpublishable(articles_params)
    assign_attributes(articles_params.merge(state: :draft))
  end

  # Check if article exists by looking up slug.
  # Returns article object if exists.
  def self.article_exists?(slug)
    Article.exists?(slug: slug)
  end

  # action to check if article is published
  def self.article_published?(article)
    article.published?
  end

  private

  def assign_slug
    self.slug = title.parameterize
  end

  def update_slug
    update_attributes slug: assign_slug
  end
end
