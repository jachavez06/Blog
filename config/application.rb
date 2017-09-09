require_relative 'boot'

require 'rails/all'
require 'fog/aws'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # For custom exceptions routes
    config.exceptions_app = ->(env) { ExceptionsController.action(:exception).call(env) }

    Groupdate.week_start = :mon # first three letters of day

    config.after_initialize do
      #cache = ActiveSupport::Cache::MemoryStore.new

      # Grab only published articles
      @articles = Article.published

      # Generate tags on published files
      @tags = []

      @articles.each do |a|
        a.tag_list.map { |b| @tags << b }
      end
      Rails.cache.write('published_tags', @tags)    
      Rails.cache.write('published_articles', @articles)
    end
    #config.exception_handler = { dev: true }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
