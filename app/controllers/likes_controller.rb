class LikesController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end
end
