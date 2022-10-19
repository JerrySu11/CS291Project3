class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    begin
      user = User.find(comment_params[:commenter].to_i)
    rescue
      flash.alert = "User not found."
      redirect_to post_path(@post) and return
    end

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
