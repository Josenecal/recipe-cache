class UserController < ApplicationController
    skip_before_action :require_login, only: :new

    def dashboard
    end

    def new
    end

    def create
        validate_password
        new_user = User.new(new_user_params)
        if new_user.save
            flash[:message] = "Welcome to the club#{new_user.first_name.present? ? ", " + new_user.first_name : nil}!"
            log_in(new_user)
            redirect_to "/dashboard"
        else
            flash[:error] = "Something went wrong, please try again"
            redirect_to :new
        end
    end

    private

    def new_user_params
        params.require(:email, :password).permit(:first_name, :last_name, :zip_code)
    end

    def validate_password
        if params[:password].nil?
            flash[:error] = "Password is required"
            render :new
        elsif params[:password]&.strip&.match? params[:password_confirmation]&.strip
            true
        else
            flash[:error] = "Passwords do not match"
            render :new
        end
    end

end