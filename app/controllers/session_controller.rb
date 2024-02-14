class SessionController < ApplicationController
skip_before_action :require_login

    def index
        redirect_to "/dashboard" if logged_in?
    end

    def destroy
        log_out
    end
end
