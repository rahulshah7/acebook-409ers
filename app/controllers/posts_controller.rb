# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @form_title = 'New Post'
    @post = Post.new
  end

  def edit
    @form_title = 'Edit Post'
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.create(message: post_params[:message], user_id: current_user.id)
    flash[:notice] = 'Successfully posted.'
    redirect_to posts_url
  end

  def index
    if(params[:user_id] == nil)
      @posts = Post.all.reverse
    else
      @posts = Post.where("user_id = ?", params[:user_id])
    end
  end

  def update
    post_id = params['id']
    user_id = Post.find(post_id).user_id

    if user_id == current_user.id
      @post = Post.find(post_id)
      if Time.current > (@post.created_at + 600)
        flash[:alert] = 'Cannot edit, posted 10 minutes ago.'
      else
        @post.update(message: post_params[:message])
        flash[:notice] = 'Successfully edited post.'
      end
    else
      flash[:alert] = "Cannot edit another user's post."
    end
    redirect_to posts_url
  end

  def destroy
    post_id = params['id']
    user_id = Post.find(post_id).user_id

    if user_id == current_user.id
      @post = Post.destroy(post_id)
      flash[:notice] = 'Successfully deleted.'
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
