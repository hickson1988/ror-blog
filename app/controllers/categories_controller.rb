class CategoriesController < ApplicationController

  before_action :require_user, except: [:index, :show]
  before_action only: [:edit, :update, :destroy] do |c| c.require_user_resource_owner(Category.find(params[:id])) end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @user=User.find(session[:user_id])
    @user.categories << @category
     if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
