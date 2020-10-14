class PartiesController < ApplicationController
  before_action :require_current_user

  def new
    @movie_title = params[:movie_title].titleize
    @movie_runtime = params[:movie_runtime]
  end

  def create
    @party = current_user.parties.new({
                                        movie_title: params[:movie_title].titleize,
                                        date: params[:party_date],
                                        time: params[:start_time]
                                      })
    if @party.save
      invite_friends(params[:invitees])
    else
      error
    end
  end

  def invite_friends(invitees)
    if invitees
      invitees.each do |user_id|
        @party.party_users.create(party_id: @party.id, user_id: user_id)
      end
    end
    redirect_to '/user/dashboard'
  end

  def error
    flash[:error] = @party.errors.full_messages.to_sentence
    render :new
  end
end
