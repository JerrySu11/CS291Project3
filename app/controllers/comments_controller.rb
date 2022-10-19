class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    begin
      user = User.find(comment_params[:commenter].to_i)
    rescue
      flash.alert = "User not found."
      redirect_to post_path(@post) and return
    end
<<<<<<< HEAD
=======

>>>>>>> 22fd3efd89e3b2caf0b13a70cff20fe7d8171db6
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
