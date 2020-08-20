class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    @like.save
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end
end
