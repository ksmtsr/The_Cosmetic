class Public::CommentsController < ApplicationController

  def new
    @comments = Comment.new
  end

  def create
    @comments = Comment.new(comment_params)
    @comments.customer_id = current_customer.id
    @comments.save
    redirect_to comments_path
  end

  def index
    @comments = current_customer.comments
    @comments = Comment.all
  end

  private

  def comment_params
    params.require(:comment).permit(:review, :customer_id, :item_id)
  end
end
