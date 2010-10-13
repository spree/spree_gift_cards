UsersController.class_eval do
  after_filter :register_gift_card, :only => :create

  private

  def register_gift_card
    return if session[:gift_card].nil?
    @gift_card = GiftCard.find_by_token(session[:gift_card])
    if @gift_card.register(current_user)
      flash[:notice] = t("gift_card_messages.activated")
      session[:gift_card] = nil
    else
      flash[:error] = t("gift_card_messages.register_error")
    end
  end
end
