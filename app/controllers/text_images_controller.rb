class TextImagesController < ApplicationController
  def new
    @text_image = TextImage.new
  end

  def create
    @text_image = TextImage.new(text_image_params)

    uploaded_image_path = params[:app][:app_image].tempfile.path
    @app.result = @app.analyze_image(uploaded_image_path)

    if @text_image.save
      redirect_to @text_image
    else
      render :new
    end
  end
end
