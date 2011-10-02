class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
    respond_to do |format|
      format.html
      format.json    end
  end
  
  def progress
    response = {:result=>-1, :new_uuid=>UUID.new.generate}
    response.merge!({:result=> request.env['rack.progress'][params[:uuid]]}) if params[:uuid] && request.env['rack.progress'][params[:uuid]]
    render :json => response    
  end
  
  def create
    @user = User.find_or_initialize_by_uuid(params[:uuid])
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html
      format.js
      format.json{ render :json => @user}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render :json => true
  end
end