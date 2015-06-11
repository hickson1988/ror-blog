class ArticlesController < ApplicationController

before_action :require_user, except: [:index, :show]
before_action only: [:edit, :update, :destroy] do |c| c.require_user_resource_owner(Article.find(params[:id])) end


  def index
    @category=Category.find(params[:category_id])
    @articles = @category.articles.order(updated_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @category=Category.find(params[:category_id])
    @article = Article.new
  end

 def newuncategorized
    @article = Article.new
    @categories=Category.all
  end

  def edit
    @allcategories=Category.all
    @article = Article.find(params[:id])
  end

  def create
    @category=Category.find(params[:category_id])
    @article=@category.articles.create(article_params)
    @user=User.find(session[:user_id])
    @user.articles << @article
    if @article.valid?
      redirect_to category_articles_path(@category)
    else
      render 'new'
    end
  end

  def createuncategorized
    @article=Article.new(article_params)
    @user=User.find(session[:user_id])
    @user.articles << @article

    if @article.valid?
      if params[:category_ids]
        params[:category_ids].each do |category_id|
          category=Category.find(category_id)
          category.articles << @article
        end
      else
         @article.save
      end
      redirect_to categories_path
    else
      @categories=Category.all
      render 'newuncategorized'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      @article.categories.delete_all
      if params[:category_ids]
        params[:category_ids].each do |category_id|
          category=Category.find(category_id)
          category.articles << @article
        end
      end
      redirect_to @article
    else
      @allcategories=Category.all
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    if params[:category_id]
      redirect_to category_articles_path(params[:category_id])
    else
      redirect_to root_path
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
