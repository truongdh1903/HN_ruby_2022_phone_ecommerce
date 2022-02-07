class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t ".success_add_comment"
      redirect_to product_url id: @comment.product_id,
                              product_detail_id: params[:product_detail_id]
    else
      add_comment_fail
    end
  end

  def destroy; end

  private
  def add_comment_fail
    flash[:danger] = t ".fail_add_comment"
    redirect_to root_url
  end

  def comment_params
    add_comment_fail unless Product.find_by id: params[:product_id]
    params.require(:comment).permit :content, :product_id
  end
end
