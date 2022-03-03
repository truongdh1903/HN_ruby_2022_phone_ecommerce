class CommentsController < ApplicationController
  authorize_resource
  before_action :check_params_destroy, only: :destroy
  before_action :check_params_create, only: :create

  def create
    @comment = current_user.comments.build @comment_params
    if @comment.save
      flash[:success] = t "comments.success_add_comment"
      build_rate if params[:number_of_stars] != Settings.default_star_rate.to_s

      redirect_to_url_product_current
    else
      handle_comment_fail
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".deleted_success"
      redirect_to_url_product_current
    else
      handle_comment_fail
    end
  end

  private
  def handle_comment_fail
    flash[:danger] = t "comments.fail_comment"
    redirect_to_shop
  end

  def check_params_create
    @comment_params = params.require(:comment).permit :content, :product_id
    handle_comment_fail unless Product.find_by id: @comment_params[:product_id]
  end

  def check_params_destroy
    handle_comment_fail unless params[:comment_id]

    @comment = Comment.find_by id: params[:comment_id]
    handle_comment_fail unless @comment
  end

  def redirect_to_url_product_current
    redirect_to product_url id: @comment.product_id,
                            product_detail_id: params[:product_detail_id]
  end

  def build_rate
    @rate = Rate.find_or_create_by user_id: @comment.user_id,
                                   product_id: @comment.product_id
    if @rate.number_of_stars
      check_update_comment @rate.update(
        number_of_stars: params[:number_of_stars],
        updated_at: Time.zone.now, comment_id: @comment.id
      )
    else
      @rate.number_of_stars = params[:number_of_stars]
      @rate.comment_id = @comment.id
      check_update_comment @rate.save
    end
  end

  def check_update_comment is_success
    if is_success
      flash[:success] = t "comments.success_vote"
    else
      flash[:danger] = t "comments.failed_vote"
    end
  end
end
