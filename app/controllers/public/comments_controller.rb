class Public::CommentsController < ApplicationController

  def new
    @comments = Comment.new
    @item_id = params[:item_id]
  end

  def create
    @comments = Comment.new(comment_params)
    @comments.customer_id = current_customer.id
    @comments.item_id = params[:item_id]
    @comments.save
    redirect_to item_comments_path(current_customer.id)
  end

  def index
    @comments = current_customer.comments
    @comments = Comment.all
  end

  def edit
    @comment = current_customer.comment
    @comment.customer_id = current_customer.id
    @item_id = params[:item_id]
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to item_comments_path(current_customer.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:review, :customer_id, :item_id)
  end
end
