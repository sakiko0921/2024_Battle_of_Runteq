class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(author: params[:author], book: params[:book], description: params[:description], transcribed_text: params[:transcribed_text], text_image: params[:text_image])

    if params[:post][:text_image].present?
      uploaded_image_path = params[:post][:text_image].tempfile.path
      @post.transcribed_text = @post.analyze_image(uploaded_image_path)

      if @post.save
        redirect_to text_images_path(transcribed_text: @post.transcribed_text)
      else
        logger.debug @post.errors.full_messages
        render :new
      end
    else
      flash[:alert] = "画像がアップロードされていません"
      render :new
    end
  end
=begin
    if @post.save
      response = @post.analyze_image(@post.text_image.path)
      @post.create_transcribed_text!(transcribed_text: response)
      redirect_to text_images_path(transcribed_text: response)
    else
      logger.debug @post.errors.full_messages
      render :new
    end
=end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
