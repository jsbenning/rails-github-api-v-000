class RepositoriesController < ApplicationController
  before_action :authenticate_user


  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]   
    end
     
    @name = JSON.parse(resp.body)["login"]

    @repos = pull_repos(@name)
    

  end

  def create
    new_repo = params["name"]
    @my_resp = post_repo(new_repo)
    render 'index'
  end

private

  def pull_repos(name)
    repo_list = Faraday.get("https://api.github.com/users/#{name}/repos?per_page=100") do |req|
    end

    my_list = JSON.parse(repo_list.body)
    my_list.map{ |x| x["name"] }
  end

  def post_repo(name)
    conn = Faraday.new(:url => 'https://api.github.com/user') 

    resp = conn.post do |req|
      req.url '/repos'
      #req.headers['Authorization'] = "token " + session[:token]
      req.headers['Content-Type'] = 'application/json'
      req.body = '{ "name": "#{name}" }'
    end

    github_response = JSON.parse(resp.body) 

    # if resp.success?
    #   github_response = JSON.parse(resp.body) + name
    # else
    #   github_response = JSON.parse(resp.body)
    # end
  end
end



    
  
