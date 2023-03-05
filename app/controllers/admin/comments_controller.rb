class Admin::CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
    @item_id = params[:item_id]
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_customer_comments_path, notice: "変更を保存しました！"
    else
      redirect_to edit_admin_comment_path(@comment)
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:review, :customer_id, :item_id, :star)
    end
end
