class UsersController < ApplicationController

   before_action :set_user ,only:[:index,:in_progress,:completed,:purchase,:purchased,:listing]

  def index
    @item = Item.where(user_id: current_user.id)
    @items = Item.be_bought(@user.id).where.not(status: 2).order("created_at DESC")
    @bought_items = Item.be_bought(@user.id).where(status: 2).order("created_at DESC")
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    @userdetail = UserDetail.find(params[:id])
  end

  def in_progress
    @items = @user.items.be_sold.where.not(status: :received).order("created_at DESC")
  end

  def completed
    @items = @user.items.be_sold.where(status: :received).order("created_at DESC")
  end

  def purchase
    @items = Item.be_bought(@user.id).where.not(status: :received).order("created_at DESC")
  end

  def purchased
    @items = Item.be_bought(@user.id).where(status: :received).order("created_at DESC")
  end

  def listing
    @items = @user.items.where(status: :stopped).order("created_at DESC") .or @user.items.where(status: :displayed).order("created_at DESC")
  end

  private

  def set_profile
    @userdetail = UserDetail.find(params[ :profile]).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find_by(id: current_user.id)
  end
end





