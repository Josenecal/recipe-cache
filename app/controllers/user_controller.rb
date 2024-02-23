class UserController < ApplicationController
    skip_before_action :require_login, only: [:new, :create, :login]

    def dashboard
    end

    def login
        matching_user = User.find_by email: login_params[:login_email]
        if matching_user.present? && matching_user.authenticate(login_params[:login_password])
            log_in(matching_user)
            flash[:message] = "Welcome back, #{matching_user.first_name}!"
            redirect_to "/dashboard"
        else
            flash[:error] = "Incorrect username or password, please try again"
            redirect_to root_path
        end
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
        params.permit(:first_name, :last_name, :zip_code, :email, :password)
    end

    def login_params
        params.permit(:login_email, :login_password)
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