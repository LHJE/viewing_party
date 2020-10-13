class FriendshipsController < ApplicationController
  before_action :require_current_user

  def create
    new_friend = User.where(email: params["New Friend's Email"])
    if new_friend == []
      flash[:notice] = 'Email Address not in our system.'
    else
      correct_email(new_friend)
    end
    redirect_to '/user/dashboard'
  end

  def correct_email(new_friend)
    user = User.where(id: Friendship.where(user_id: new_friend[0].id).pluck(:friend_id)).where(id: current_user.id)
    if current_user.id == new_friend[0].id
      flash[:notice] = "Well that's your email address! We do like that you're trying to be your own friend though :)"
    elsif user[0].nil?
      Friendship.create!(user_id: current_user.id, friend_id: new_friend[0].id)
      Friendship.create!(user_id: new_friend[0].id, friend_id: current_user.id)
    else
      flash[:notice] = "They're already your friend!"
    end
  end
end
