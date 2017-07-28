class Article < ApplicationRecord
    validates :title, presence: true, length: {minimum:3, maximum:50}
    validates :content, presence:true, length: {minimum: 10} 

    def slug
    
    end 
    
    def to_param

    end 
end
