class Public::CommentsController < ApplicationController
   before_action :is_matching_login_customer, only: [:edit, :update]

  def new
    @comments = Comment.new
    @item_id = params[:item_id]
  end

  def create
    @comments = Comment.new(comment_params)
    @comments.customer_id = current_customer.id
    @comments.item_id = params[:item_id]
    if @comments.save
      redirect_to item_comments_path(current_customer.id), notice: "口コミを投稿しました"
    else
      render :new
    end
  end

  def comments
    if params[:latest]
      @comments = Comment.latest
    elsif params[:old]
      @comments = Comment.old
    elsif params[:star_count]
      @comments = Comment.star_count
    else
      @comments = Comment.all
    end
  end

  def index
    @comments = current_customer.comments
    @customer = current_customer
    @item_id = params[:item_id]
  end

  def edit
    @comment = Comment.find(params[:id])
    @comment.customer_id = current_customer.id
    @item_id = params[:item_id]
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to item_comments_path(current_customer.id), notice: "変更を保存しました"
    else
      redirect_to edit_admin_comment_path(@comments)
    end
  end



  private

    def is_matching_login_customer
      comment = Comment.find(params[:id])
      customer = comment.customer
      unless customer.id == current_customer.id
        redirect_to customers_path
      end
    end

    def comment_params
      params.require(:comment).permit(:review, :customer_id, :item_id, :star)
    end

end
