module Lookupable
    include ActiveSupport::Concern

    # Check if article exists by looking up slug. 
    # Returns article object if exists.
    def article_exists? (slug)
        Article.exists?(slug: slug)
    end

    # action to check if article is published
    def article_published? (article)
        article.published
    end
end