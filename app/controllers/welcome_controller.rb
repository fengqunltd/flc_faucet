class WelcomeController < ApplicationController

    def index
        write_referral_cookie(params[:r]) if params[:r]
    end

    def error_404
        render status: 404, layout: false, template: 'welcome/error_404.html.erb'
    end

    def refscoreboard
        puts params[:scope]
        @range = FLcAccount.dates_range(params[:scope])
        selector =  @range ? FLcAccount.where(created_at: @range) : FLcAccount
        @refs = selector.grouped_by_referrers
        @total = selector.count
        if request.xhr?
            render '_refs', layout: false
            return
        end

    end

end
