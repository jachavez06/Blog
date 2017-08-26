# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://guides.jesuschavez.org"

# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'

# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
  aws_access_key_id: '<%= ENV["aws_access_key_id"] %>',
  aws_secret_access_key: '<%= ENV["aws_secret_access_key"] %>',
  fog_directory: 'jchavez-guides-sitemap',
  fog_region: 'us-west-2')

# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-us-west-2.amazonaws.com/jchavez-guides-sitemap/"

# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  add articles_path, :priority => 0.7, :changefreq => 'daily'

#Add all articles:

  Article.where(published: true).find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end
end
