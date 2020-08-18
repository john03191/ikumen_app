class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    @users = User.all.order(id: "DESC").limit(10)
  end

  def list
    @posts = Post.all
  end

  def show
    @like = Like.new
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "記事を投稿しました。"
    else
      render :new
    end
  end

  def edit
    if @post.user != current_user
        redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(post.user), notice: "投稿を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :comment)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
