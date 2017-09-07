# Articles for the site.
class Article < ApplicationRecord
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true

  # Callbacks
  after_create :update_slug
  before_update :assign_slug

  # Enum
  enum state: %i[draft published]
  # Regex
  @keyword_regex = /\A([a-z]+|[0-9]+)(,\s([a-z]+|[0-9]+))*\z/i

  # Associations
  acts_as_taggable_on :tags

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
  ##########

  ### BEGIN SCOPES ###
  scope :published, -> { where(state: :published) }
  #### END SCOPES ####

  ### TAGS ###
  # Checks that object has at least one tag
  def tags?
    return false unless tags.present?
    true
  end

  # Styles tags to display on Article's show page
  def styled_tags
    to_return = '<span class="badge badge-pill badge-default">'
    tags = tag_list.join('</span><span class="badge badge-pill badge-default">')
    to_return + tags + '</span>'
  end

  ### PUBLISH ###
  def make_publishable(articles_params)
    assign_attributes(articles_params.merge(state: :published,
                                            created_at: Time.zone.now,
                                            updated_at: Time.zone.now))
  end

  def make_unpublishable(articles_params)
    assign_attributes(articles_params.merge(state: :draft))
  end

  ### STATE ###
  # Does an article with the given slug exist?
  def self.article_exists?(slug)
    Article.exists?(slug: slug)
  end

  def edited?
    @current_tag_list = tag_list
    @saved_tag_list = Article.find(id).tag_list
    @tags_diff = @current_tag_list - @saved_tag_list
    changed? || @tags_diff.present?
  end

  ### SLUG ###
  def to_param
    slug
  end

  private

  def assign_slug
    self.slug = title.parameterize
  end

  def update_slug
    update_attributes slug: assign_slug
  end
end
