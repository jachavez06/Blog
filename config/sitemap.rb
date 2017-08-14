# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://guides.jesuschavez.org"

# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'

# store on S3 using Fog 
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
  aws_access_key_id: 'AKIAIBK235LTI4VDGWVA',
  aws_secret_access_key: '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',
  fog_directory: 'jchavez-guides-sitemap',
  fog_region: 'us-west-2')

# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-us-west-2.amazonaws.com/jchavez-guides-sitemap/"

# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
   #Add '/articles'
  
  add articles_path, :priority => 0.7, :changefreq => 'daily'

#Add all articles:

  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end
end
