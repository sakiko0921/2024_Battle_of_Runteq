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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path(id: @post.id)
    else
      render :edit
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:author, :book, :description, :transcribed_text, :text_image)
  end
end
