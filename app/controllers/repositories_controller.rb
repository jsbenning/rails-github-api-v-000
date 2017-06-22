class RepositoriesController < ApplicationController
  before_action :authenticate_user


  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]   
    end
     
    @name = JSON.parse(resp.body)["login"]
    @repos = pull_repos(@name)
    
    

  end

  def create #THE PROBLEM STARTS IN THIS ACTION

    @new_repo = params["name"]
    @my_resp = post_repo(@new_repo) #I PASS THE FORM PARAM ("NAME")TO THE POST_REPO METHOD

    render 'index' #rendering, rather than redirecting, to view response
  end

private

  def pull_repos(name)
    repo_list = Faraday.get("https://api.github.com/users/#{name}/repos?per_page=100") do |req|
    end

    my_list = JSON.parse(repo_list.body)
    my_list.map{ |x| x["name"] }
  end



                     #THIS METHOD IS GIVING ME PROBLEMS 
  def post_repo(name)
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = '{ "name" : name }'
    end

    github_response = resp.body #to see the response as the returned value
  end
end

                      #SOME ALTERNATIVE ATTEMPTS:  
                    #ATTEMPT WITH FARADAY'S BUILDER MODULE
    # conn = Faraday.new(url: 'https://api.github.com') do |builder|
    #   builder.use Faraday::Request::TokenAuthentication, session[:token]
    # end

    # resp = conn.post do |req|
    #   req.url '/user/repos'
    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = '{ "name": name }'
    # end




                   #ATTEMPT WITH PASSING TOKEN_AUTH IN BLOCK
    # conn = Faraday.new(:url => 'https://api.github.com') do |req|
    #   req.token_auth( 'session[:token]' )
    # end

    # resp = conn.post do |req|
    #   req.url '/user/repos'
    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = '{ "name": name }'
    # end


                  #ATTEMPT PASSING TOKEN IN HEADER
    # conn = Faraday.new(:url => 'https://api.github.com')

    # resp = conn.post do |req|
    #   req.url '/user/repos'
    #   req.headers['Authorization'] = "token " + session[:token]

    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = '{ "name": name }'
    # end

    # if resp.success?
    #   redirect_to root_path
    # else
    #   github_response = JSON.parse(resp.body)
    # end




    
  
