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
    @posts = Post.all.reverse
  end

  def destroy
    post_id = params['id']
    user_id = Post.find(post_id).user_id

    if user_id == current_user.id
      @post = Post.destroy(post_id)
      flash[:notice] = "Successfully deleted."
    else
      flash[:alert] = "Cannot delete another user's post."
    end
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
