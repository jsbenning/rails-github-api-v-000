class SessionsController < ApplicationController
  skip_before_action :authenticate_user


  def create
    #if params[:state] == ENV['GITHUB_STATE'] ---this should be here, but it might futz up the tests
      resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.headers['Accept'] = 'application/json'
        req.params['client_id'] = ENV['GITHUB_ID']
        req.params['client_secret'] = ENV['GITHUB_SECRET']
        req.params['code'] = params[:code]
        req.params['redirect_uri'] = "http://localhost:3000/auth"
        req.params['state'] = ENV['GITHUB_STATE']  
      end

      body = JSON.parse(resp.body)
      session[:token] = body['access_token']
      redirect_to root_path


    # else
    #   flash[:message] = "Incorrect state passed!"
    # end 
  end
 
end
