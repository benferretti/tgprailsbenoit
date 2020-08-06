class DynamicPagesController < ApplicationController
  
  def home
    params[:user] = User.find(params[:id])
    params[:gossips] = Gossip.where(user_id: params[:user].id)
  end
  
end
