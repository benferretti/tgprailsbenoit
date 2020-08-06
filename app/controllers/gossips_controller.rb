class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :show, :edit, :create, :update] 


  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comments = Comment.all
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content],user: User.find(current_user.id)) 

    if @gossip.save
      flash[:success] = "Merci #{@gossip.user.first_name} ! Nous avons pu créer le gossip : #{@gossip.title} "
      redirect_to :controller => 'static_pages', :action => 'index'
    else
      flash[:danger] = "Nous n'avons pas réussi à créer le potin pour la (ou les) raison(s) suivante(s) : #{@gossip.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'new'
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
    if @gossip.update(gossip_params)
      flash[:success] = "Merci #{@gossip.user.first_name} ! Nous avons pu modifier le gossip : #{@gossip.title} "
      redirect_to :controller => 'gossips', :action => 'show'
    else
      flash[:danger] = "Nous n'avons pas réussi à modifier le potin pour la (ou les) raison(s) suivante(s) : #{@gossip.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'edit'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    if @gossip.destroy
      flash[:success] = "Merci #{@gossip.user.first_name} ! Nous avons pu supprimer le gossip : #{@gossip.title} "
      redirect_to :controller => 'static_pages', :action => 'index' 
    else
      flash[:danger] = "Nous n'avons pas réussi à suppimer le potin pour la (ou les) raison(s) suivante(s) : #{@gossip.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'show'
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Si tu veux gossiper merci de te log :)"
      redirect_to new_session_path
    end
  end

end
