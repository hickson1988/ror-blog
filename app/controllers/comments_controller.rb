class CommentsController < ApplicationController

  before_action :require_user, only: [:create,:destroy]
  before_action only: [:destroy] do |c| c.require_user_resource_owner(Comment.find(params[:id])) end

  def create
    @user=User.find(session[:user_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @user.comments << @comment

    redirect_to article_path(@article)
  end

def destroy
    @comment =Comment.find(params[:id])
    @article=@comment .article
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
