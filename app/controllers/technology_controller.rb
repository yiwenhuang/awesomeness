class TechnologyController < ApplicationController
  def index
    @technologies = Technology.all.includes(:categories)
  end

  def new
    @tech = Technology.new
    @tech.categories.build
  end

  SubmitQuery = SWAPI::Client.parse <<-'GRAPHQL'
    query ($owner: String!, $name: String!) {
      repository(owner:$owner, name:$name) {
        watchers(last: 2) {
          edges {
            node {
              name
            }
          }
        }
        viewerHasStarred
        stargazerCount
        forkCount
        updatedAt
        forks(last: 2) {
          edges {
            node {
              id
              updatedAt
            }
          }
        }
      }
    }
  GRAPHQL

  def create
    repo_ary = technology_params[:repo_url].split("/")
    repo_result = SWAPI::Client.query(SubmitQuery, variables: {name: repo_ary.last, owner: repo_ary.last(2)[0]})

    @tech = Technology.find_or_create_by({name: technology_params[:name], repo_url: technology_params[:repo_url]})

    if @tech && repo_result
      @tech.star_count = repo_result.data.repository.stargazer_count
      @tech.fork_count = repo_result.data.repository.fork_count
      @tech.last_commit_at = repo_result.data.repository.updated_at
      @tech.save
      category = Category.find_or_create_by({name: technology_params[:categories_attributes]["0"][:name], technology_id: @tech.id})
      redirect_to technology_index_url
    else
      flash.alert = "No record created!"
      render :action => :new
    end
  end

  protected

  def technology_params
    params.require(:technology).permit(:name, :repo_url, categories_attributes: [:name])
  end
end
