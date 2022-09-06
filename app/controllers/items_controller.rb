class ItemsController < ApplicationController
  before_action :repeat_code,only: [:show ,:edit , :update]
  before_action :authenticate_user!,only: [:new , :edit , :update]
  before_action :correct_signin_user, only: [:edit , :update]
 
  

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
end
