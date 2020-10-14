class InvitationController < ApplicationController
  before_action :require_current_user

  def create
    @invitiation = InvitationGenerator.new
    recipient = params[:friends_email]
    email_info = {
      user: current_user,
      friend: params[:friends_name],
      message: @invitiation.message
    }
    FriendNotifierMailer.inform(email_info, recipient).deliver_now
    flash[:notice] = 'Thank you for sending an invitiation.'
    redirect_to '/user/dashboard'
  end
end
