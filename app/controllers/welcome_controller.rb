class WelcomeController < ApplicationController
  def index
    @articles = Article.page(params[:page]).order(created_at: :desc)
  end
end
