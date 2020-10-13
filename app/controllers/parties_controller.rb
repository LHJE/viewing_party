class PartiesController < ApplicationController
  before_action :require_current_user

  def new
    @movie_title = params[:movie_title].titleize
    @movie_runtime = params[:movie_runtime]
  end

  def create
    party = current_user.parties.create({
                                          movie_title: params[:movie_title],
                                          date: params[:party_date],
                                          time: params[:start_time]
                                        })

    params[:invitees].each do |user_id|
      party.party_users.create(party_id: party.id, user_id: user_id)
    end
    redirect_to '/user/dashboard'
  end
end
