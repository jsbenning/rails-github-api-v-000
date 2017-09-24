class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    # def authenticate_user #first method called (unless logged in); users redirected to request github id
    #   client_id = ENV['GITHUB_ID']
    #   redirect_uri = CGI.escape("http://localhost:3000/auth")
    #   state = ENV['GITHUB_STATE']
    #   github_url = "http://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}" #scope=user%20public_repo
    #   redirect_to github_url unless logged_in?    
    # end

    def authenticate_user
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_ID']}&scope=repo" if !logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end


