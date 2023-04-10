class RatingController < ApplicationController
  before_action :set_topic
  before_action :set_post
  load_and_authorize_resource

  def create
    @find = Rating.includes(:post).find_by(post_id: @post.id, user_id: current_user.id)
    if @find.present?
      if rating_params[:rating].to_i == 0
        @find.destroy
        redirect_to topic_post_path(@topic, @post)
      else
      if @find.update(rating_params)
        redirect_to topic_post_path(@topic, @post)
      else
        redirect_to topic_post_path(@topic, @post)
      end
      end
    else

      @rating = Rating.new(rating_params)
      @rating.post_id = @post.id
      @rating.user_id = current_user.id
      if @rating.save
        redirect_to topic_post_path(@topic, @post)
      else
        redirect_to topic_post_path(@topic, @post)
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def rating_params
    params.require(:rating).permit(:rating)
  end


end