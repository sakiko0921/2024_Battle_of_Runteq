class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # ユーザー登録が成功した場合はMyPageにリダイレクト
    if @user.save
      redirect_to login_path, notice: "ユーザー登録が完了しました"
    else
      render :new
    end
  end

  private

  def user_params
    # Strong parameters: whitelist the attributes that can be updated by the user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
