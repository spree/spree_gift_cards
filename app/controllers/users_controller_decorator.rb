UsersController.class_eval do
  after_filter :register_gift_card, :only => :create

  private

  def register_gift_card
    return if session[:gift_card].nil?
    @gift_card = GiftCard.find_by_token(session[:gift_card])
    if @gift_card.register(current_user)
      flash[:notice] = "Gift card activated, now you have store credit and can use it to pay for purchases in full or in part"
      session[:gift_card] = nil
    else
      flash[:error] = "Couldn't register gift card"
    end
  end
end
