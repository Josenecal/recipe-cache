class SessionsController < ApplicationController
skip_before_action :require_login

    def index
        redirect_to root_path if logged_in?
    end

    def create
        matching_user = User.find_by email: login_params[:login_email]
        if matching_user.present? && matching_user.authenticate(login_params[:login_password])
            log_in(matching_user)
            flash[:message] = "Welcome back, #{matching_user.first_name}!"
            redirect_to root_path
        else
            flash[:error] = "matching_user: #{matching_user}. authenticate: #{matching_user&.authenticate(login_params[:login_password])}"
            redirect_back_or_to root_path
        end
    end

    def destroy
        log_out
    end

    private 

    def login_params
        params.permit(:login_email, :login_password)
    end
end
