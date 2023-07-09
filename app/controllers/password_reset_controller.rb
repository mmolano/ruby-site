class PasswordResetController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      # mail
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path,
                notice: 'If an account with that email exists, we have sent the link to reset your password'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'reset_password')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, alert: 'Token is expired'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'reset_password')
    if @user.update(password_params)
      redirect_to login_path, notice: 'Password has been updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
