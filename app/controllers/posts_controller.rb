class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_topic, except: %i[ all_post posts]

  load_and_authorize_resource
  def all_post
        if params[:from_date] && params[:to_date] && ( params[:from_date].present? || params[:to_date].present?)

          @posts = Post.between_dates(params[:from_date], params[:to_date])
        else
          to_date = Date.today
          from_date = 1.day.ago.to_date
          @posts = Post.between_dates(from_date, to_date)
        end

        @all_posts = @posts.paginate(page: params[:page], per_page: 10)
  end

  def posts
    @all_posts = Post.paginate(page: params[:page], per_page:10)
  end


  # GET /posts or /posts.json
  def index
    @posts = @topic.posts
    @status = @posts.map do |post|
      post.users.exists?(id: current_user.id) ? 'Read' : 'Unread'
    end

  end


  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments
    @tags = @post.tags
    @rating = Rating.new
    @commentrating = Commentrating.new
    @select = @post.ratings.where(user_id: current_user.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.tags.build
    @all_tags = Tag.all
  end



  # GET /posts/1/edit
  def edit

    @tag = @post.tags.pluck(:hashtag)
    @tag_name = @tag.join(" ")
    @all_tags = Tag.all
  end

  def read_post
    @check = @post.users.exists?(id: current_user.id)
    if  @check

    else
      @post.users << current_user

    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.topic_id = @topic.id
    @post.user_id = current_user.id
    tag_array = tag_params
    temp = tag_array[:tags_attributes]
    tags = temp[:hashtag].split(" ")
    tags.each do |t|
      tag = Tag.find_by_hashtag(t)
      if tag.present?
        @post.tags << tag
      else
        tag = Tag.new(hashtag: t)
        if tag.save
          @post.tags << tag
        end
      end
      end

    respond_to do |format|
      if @post.save
        format.js
        format.json { render :show, status: :created, location: @post }
      else
        format.js
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        tag_array = tag_params
        @post.tags.clear
        temp = tag_array[:tags_attributes]
        tags = temp[:hashtag].split(" ")
        tags.each do |t|
          tag = Tag.find_by_hashtag(t)
          if tag.present?
            @post.tags << tag
          else
            tag = Tag.new(hashtag: t)
            if tag.save
              @post.tags << tag
            end
          end
        end
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_path(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

  def set_topic
    begin
      @topic = Topic.find(params[:topic_id])
    rescue
      redirect_to all_post_path
    end
  end


    def post_params
      params.require(:post).permit(:title, :description, :image)
    end

  def tag_params
    params.require(:post).permit(tags_attributes: [:hashtag])
  end



end
