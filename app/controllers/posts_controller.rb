class PostsController < ApplicationController
  def new
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(author: params[:author], book: params[:book], description: params[:description], transcribed_text: params[:transcribed_text], text_image: params[:text_image])

    if @post.save(post_params)
      redirect_to posts_path(id: @post.id)
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path(id: @post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def index
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page])
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:author, :book, :description, :transcribed_text, :text_image)
  end
end
