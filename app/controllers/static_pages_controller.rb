class StaticPagesController < ApplicationController

  def index
    @gossips = Gossip.all
  end

  def team
  end

  def contact
  end

end
