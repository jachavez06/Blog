class WelcomeController < ApplicationController
  def index
    set_meta_tag description: 'A blog where I post code tutorials so that others can learn from my experience.'
    set_meta_tags keywords: 'Blog, Code, Tutorial, Guide, Example, Program'
  end
end
