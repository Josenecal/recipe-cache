class ApplicationController < ActionController::Base
    before_action :require_login
    helper_method :"logged_in?", :current_user

    def current_user
        @user ||= User.find_by(id: session[:user_id])
    end

    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out
        session[:user_id] = nil
        redirect_to root_path
    end

    private

    def require_login
        unless logged_in? 
            flash[:error] = "Sorry friend, you don't seem to be logged in. Please enter your email an password or create a new account to continue."
            redirect_to root_path
        end
    end

    def logged_in?
        session[:user_id].present? 
    end

end
