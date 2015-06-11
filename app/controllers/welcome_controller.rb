class WelcomeController < ApplicationController
  def index
    @articles = Article.all.order(updated_at: :desc)
  end
end
