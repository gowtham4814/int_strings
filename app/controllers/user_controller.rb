class UserController < ApplicationController
  def edit
    @user = current_user

  end
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to request.referrer, notice: "Updated successfully!"
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
