class ItemsController < ApplicationController
  before_action :repeat_code,only: [:show ,:edit , :update,:destroy]
  before_action :authenticate_user!,only: [:new , :edit , :update ,:destroy]
  before_action :correct_signin_user, only: [:edit , :update , :destroy]
  before_action :already_pay, only: [:edit , :update , :destroy]
 
 
 
  

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    # 復習のため  authenticate_user!を適用することで4行が省略出来た！
    # if user_signed_in? 
    @item = Item.new
    # else
    # redirect_to new_user_session_path
    # end
  end

  def create
    
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
      
    else
      render :edit
    end
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end


 


  private

  def item_params
    params.require(:item).permit(:item_name,:explanation,:category_id,:condition_id,:send_fee_id,:prefecture_id,:delivery_date_id,:price, :image).merge(user_id: current_user.id)
  
  end

  def repeat_code
    @item = Item.find(params[:id])
  end


  def correct_signin_user
    # 復習のため  authenticate_user!を適用することで4行が省略出来た！
    # if user_signed_in? 
    redirect_to root_path unless current_user == @item.user
    # else
    # redirect_to new_user_session_path
    # end
  end

  def already_pay
    # @item = Item.find(params[:id]) 復習用 引数repeat_coadであるから記載する必要なし
    redirect_to root_path if  @item.order.present?
    # 読み方  correct_signin_userユーザーの正誤は確かめられてる  かつ オーダーテーブルに存在するならredirect
  end

  
end
