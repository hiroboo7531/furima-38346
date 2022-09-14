class OrdersController < ApplicationController
  
  # items_controllerのshowアクションの購入ボタンを押したらここに飛ぶように設定
  # ここでnewとcreateでFormオブジェクトに接続
  before_action :authenticate_user!
  before_action :already_pay_item, only: [:index, :create]
  


  def index
    # @item = Item.find(params[:item_id])  復習用 まとめよう、already_payでまとめられてる
    @order_send_info = OrderSendInfo.new
    
  end

  def create
    # @item = Item.find(params[:item_id]) 復習用 まとめよう、already_payでまとめられてる、
    # 別の引数でインスタンス変数設定だけのbefore_actionを作ることもできる
    # binding.pry、を押してターミナルでparams入力して送られている内容を確認
    @order_send_info = OrderSendInfo.new(order_params)
    # .newはインタンス変数を生成するための
        if@order_send_info.valid? 

          pay_item
          @order_send_info.save
          redirect_to root_path
        else
          render :index
        end
  end
  private
    def find_repeat
      @item = Item.find(params[:item_id])
    end

    def order_params
      # この時点では、order_idが不要。またrequire外の情報は参照するため、mergeとする。
      params.require(:order_send_info).permit(:post_number, :prefecture_id, :city_ward, :address, :building_name, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
    end
    def already_pay_item
      @item = Item.find(params[:item_id])
        redirect_to root_path if @item.order.present?
    end

    def pay_item
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,        # 商品の値段
        card: order_params[:token], # カードトークン
        currency: 'jpy'             # 通貨の種類（日本円）
      )
    end
    

end
