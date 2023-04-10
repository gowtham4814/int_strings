class CommentController < ApplicationController
  before_action :set_post
  before_action :set_topic
  load_and_authorize_resource
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to topic_post_path(@topic, @post)
    else
      redirect_to topic_post_path(@topic, @post)
    end
  end

  def show
    @comment = Comment.includes(commentratings: :user).find(params[:id])
    @all_raters = @comment.commentratings
    @users = []
    @all_raters.each do |rater|
      @users.push(rater.user)
    end
    render :'posts/rating_show'
  end



  def comment_rating
    @comment = Comment.find(params[:id])
    @commentrating = Commentrating.new(comment_rating_params)
    @commentrating.comment_id = @comment.id
    @commentrating.user_id = current_user.id
    @check = Commentrating.find_by(user_id: current_user.id, comment_id: @comment.id)
    if @check.nil?
    if @commentrating.save
      redirect_to show_rating_path(@topic, @post, @comment)
    else
      redirect_to show_rating_path(@topic, @post, @comment)
    end
    else
      redirect_to show_rating_path(@topic, @post, @comment)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to topic_post_path(@topic, @post)
    else
      redirect_to topic_post_path(@topic, @post)
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to topic_post_path(@topic, @post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_topic
      @topic = Topic.find(params[:topic_id])

  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:comment)
  end

    def comment_rating_params
      params.require(:commentrating).permit(:rating)
    end

end
