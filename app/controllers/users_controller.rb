class UsersController < ApplicationController
    skip_before_action :require_login, only: [:create]

    def create
        validate_password
        new_user = User.new(new_user_params)
        new_user.save ? successful_save(new_user) : failed_save(new_user)
    end

    private

    def new_user_params
        params.require(:user).permit(:first_name, :last_name, :zip_code, :email, :password)
    end

    def password_match_param
        params.require(:user).permit(:password_confirmation)[:password_confirmation]
    end

    def validate_password
        if new_user_params[:password].nil?
            flash[:error] = "Password is required"
            redirect_back_or_to root_path
        elsif new_user_params[:password]&.strip&.match? password_match_param&.strip
            true
        else
            flash[:error] = "Passwords do not match"
            redirect_back_or_to root_path
        end
    end

    def successful_save(new_user)
        flash[:message] = "Welcome to the club#{new_user.first_name.present? ? ", " + new_user.first_name : nil}!"
        log_in(new_user)
        redirect_to root_path
    end

    def failed_save(new_user)
        flash[:error] = "Something went wrong, please try again"
        redirect_back_or_to '/login'
    end
end