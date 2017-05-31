class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authenticate_user
    end

    def logged_in?
      !!session[:token]
    end
end


=begin
from post lab

  def authenticate_user
    client_id = "ZNGFAGHHFLSVHSNO51ANV20E3XTWTH4F5212DBD3BN05RD1G"#ENV['FOURSQUARE_CLIENT_ID']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    redirect_to foursquare_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end

=end