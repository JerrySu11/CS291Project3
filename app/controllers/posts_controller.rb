class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) rescue not_found
  end

  def new
    @post = Post.new
  end

  def create
    begin
      user = User.find(post_params[:user_id].to_i)
    rescue
      flash.alert = "User not found."
      redirect_to new_post_path and return
    end

    @post = Post.new(title:post_params[:title],body:post_params[:body],user:user)

    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end



  def edit
    @post = Post.find(params[:id]) rescue not_found
  end

  def update
    @post = Post.find(params[:id]) rescue not_found

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id]) rescue not_found
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
