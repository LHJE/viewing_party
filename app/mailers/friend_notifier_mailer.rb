class FriendNotifierMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:user]
    @message = info[:message]
    @friend = info[:friend]

    mail(
      reply_to: @user.email,
      to: recipient,
      subject: "Rejoice #{@friend}! #{@user.name} is sending you an invitation to a Viewing Party!"
    )
  end
end
