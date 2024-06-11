class MyPagesController < ApplicationController
  def top
    @posts = Post.order("Random()").limit(1)
    @post = @posts.new
  end

  def create
    @post = Post.new(transcribed_text: params[:transcribed_text], text_image: params[:text_image])

    if params[:post][:text_image].present?
      uploaded_image_path = params[:post][:text_image].tempfile.path
      @post.transcribed_text = @post.analyze_image(uploaded_image_path)

      if @post.save
        redirect_to edit_post_path(id: @post.id)
      else
        render :new
      end
    else
      flash[:alert] = "画像がアップロードされていません"
      render :new
    end
  end
end
