class Article < ApplicationRecord
    # Body
    validates :title, presence: true, :uniqueness => {:case_sensitive => false}, length: {minimum: 10, maximum: 50}
    validates :content, presence: true, length: {minimum: 500} 
    
    # Meta-data
    @keyword_regex = /\A([a-z]+)(,\s*[a-z]+)*\z/i
    validates :meta_data_title, presence: true, :uniqueness => {:case_sensitive => false}, length: {minimum: 10} 
    validates :meta_data_description, presence: true, length: {minimum: 160} 
    validates :meta_data_keywords, presence: true, :format => { :with => @keyword_regex, :message => "Invalid keyword format." }, length: {minimum: 3} 

    after_create :update_slug
    before_update :assign_slug 

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
