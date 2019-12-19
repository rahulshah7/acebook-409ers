# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(message: post_params[:message], user_id: current_user.id)
    redirect_to posts_url
  end

  def index
    if(params[:user_id] == nil)
      @posts = Post.all.reverse
    else
      @posts = Post.where("user_id = ?", params[:user_id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
