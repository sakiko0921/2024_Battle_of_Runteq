class UsersSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    if login(params[:email], params[:password])
      redirect_to my_page_path, notice: "ログインしました"
    else
      @user = User.new(email: params[:email])
      flash.now[:alert] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other, notice: "ログアウトしました"
  end
end
