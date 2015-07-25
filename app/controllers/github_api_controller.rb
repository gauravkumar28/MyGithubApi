class GithubApiController < ApplicationController
  
  def index
  end

  def show
  end

  def list
    @user = params[:user]
    @repo = params[:repo]
    repos = Github::Client::Repos.new
    @response = repos.branches @user, @repo
    @commits = repos.commits.list @user, @repo
    @releases = repos.releases.list @user, @repo

  end

  def create
    @user = params[:user]
    password = params[:password]
    @github = Github.new basic_auth: "#{@user}:#{password}"

    begin
      @github.repos.list
    rescue
      flash[:error] = "Authentication Error!!"
      @error = true
    end
    
    render "show"
  end

end
