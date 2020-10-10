class FriendshipsController < ApplicationController
  def create
    new_friend = User.where(email: params["New Friend's Email"])
    if new_friend == []
      flash[:notice] = 'Email Address not in our system.'
    else
      already_friend = User.where(id: Friendship.where(user_id: new_friend[0].id).pluck(:friend_id)).or(User.where(id: Friendship.where(friend_id: new_friend[0].id).pluck(:user_id))).where(id: current_user.id)
      if current_user.id == new_friend[0].id
        flash[:notice] = "Well that's your email address! We do like that you're trying to be your own friend though :)"
      elsif already_friend[0].nil?
        Friendship.create(user_id: current_user.id, friend_id: new_friend[0].id)
        # if this is what we have to do to get that other line longer, then we can implement this feature:
        # Friendship.create(user_id: friend[0].id, friend_id: current_user.id)
      else
        flash[:notice] = "They're already your friend!"
      end
    end
    redirect_to '/user/dashboard'
  end
end
