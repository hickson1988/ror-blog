class ArticlesController < ApplicationController

  def index
    @category=Category.find(params[:category_id])
    @articles = @category.articles
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
    if @article.valid?
      redirect_to category_articles_path(@category)
    else
      render 'new'
    end
  end

  def createuncategorized
    @article=Article.new(article_params)

    if @article.valid?
      params[:category_ids].each do |category_id|
        category=Category.find(category_id)
        category.articles << @article
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
      params[:category_ids].each do |category_id|
        category=Category.find(category_id)
        category.articles << @article
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

    redirect_to category_articles_path(params[:category_id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
