class ChartsController < ApplicationController
    def new_users
        render json: User.group_by_day(:created_at, format: "%a", last: 7, current: false).count 
    end 
end
