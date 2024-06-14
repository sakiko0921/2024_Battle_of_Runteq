class MyPagesController < ApplicationController
  def top
    @posts = current_user.posts.order("Random()").limit(1)
    @post = @posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if params[:post][:text_image].present?
      uploaded_image_path = params[:post][:text_image].tempfile.path
      @post.transcribed_text = @post.analyze_image(uploaded_image_path)

      if @post.save
        redirect_to edit_post_path(id: @post.id)
      else
        puts @post.errors.full_messages
        render :my_page
      end
    else
      flash[:alert] = "画像がアップロードされていません"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:author, :book, :description, :text_image)
  end
end
