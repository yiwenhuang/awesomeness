class TechnologyController < ApplicationController
  def index
    @technologies = Technology.all.includes(:categories)
  end

  def new
    @tech = Technology.new
    @tech.categories.build
  end

  def create
    @tech = Technology.find_or_create_by({name: technology_params[:name], repo_url: technology_params[:repo_url]})

    if @tech
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
