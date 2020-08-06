class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :show, :edit, :create, :update]


  def index
    @comments = Comment.all
  end

  def show
    set_comment
  end

  def new
    @comment = Comment.new
  end


  def create
    @comment = Comment.new(content: params[:content], user: User.find(current_user.id), gossip: Gossip.find(params[:gossip_id]))

    if @comment.save
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu créer votre commentaire : #{@comment.content} "
      redirect_to :controller => 'gossips', :action => 'show' , id: Gossip.find(params[:gossip_id])
    else
      flash[:danger] = "Nous n'avons pas réussi à créer le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'new'
    end
  end

  def edit
    set_comment
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    set_comment
    comment_params 
    if @comment.update(comment_params)
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu modifier votre commentaire : #{@comment.content} "
      redirect_to :controller => 'gossips', :action => 'show' , id: Gossip.find(params[:gossip_id])
    else
      flash[:danger] = "Nous n'avons pas réussi à modifier le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      redirect_to :action => 'edit'
    end
  end

  def destroy
    set_comment
    puts "je destroy"
    if @comment.destroy
      puts 'on est dans le if'
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu supprimer le commentaire : #{@comment.content} "
      redirect_to :controller => 'static_pages', :action => 'index'
    else
      puts 'on est dans le else'
      flash[:danger] = "Nous n'avons pas réussi à suppimer le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
    @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:content)
    end

    private

  def authenticate_user
    unless current_user
      flash[:danger] = "Si tu veux commenter ce gossip merci de te log :)"
      redirect_to new_session_path
    end
  end
end
