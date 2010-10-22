class GiftCardsController < Spree::BaseController
  helper 'admin/base'
  def new
    find_gift_card_variants
    @gift_card = GiftCard.new
  end

  def create
    @gift_card = GiftCard.new(params[:gift_card])
    if @gift_card.save
      @order = current_order(true)
      line_item = @order.add_variant(@gift_card.variant, 1)
      @gift_card.line_item = line_item
      @gift_card.user = current_user
      @gift_card.save
      redirect_to cart_path
    else
      find_gift_card_variants
      render :action => :new
    end
  end

  def edit
    @gift_card = GiftCard.find(params[:id])
    access_forbidden unless @gift_card && @gift_card.user == current_user
  end

  def update
    @gift_card = GiftCard.find(params[:id])
    access_forbidden unless @gift_card && @gift_card.user == current_user && !@gift_card.is_received?
    params[:gift_card].delete(:variant_id)
    if @gift_card.update_attributes(params[:gift_card])
      OrderMailer.gift_card_email(@gift_card).deliver if @gift_card.sent_at.present?
      flash[:notice] = t("gift_card_messages.successfully_updated")
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def activate
    @gift_card = GiftCard.find_by_token(params[:id])
    if @gift_card.is_received
      flash[:error] = t("gift_card_messages.cant_activate")
      redirect_to root_url
      return
    end

    if current_user && !current_user.anonymous?
      if @gift_card.register(current_user)
        flash[:notice] = t("gift_card_messages.activated")
      else
        flash[:error] =  t("gift_card_messages.register_error")
      end
    else
      session[:gift_card] = @gift_card.token
      flash[:notice] = t("gift_card_messages.authorization_required")
    end
    redirect_to root_url
  end

  private

  def find_gift_card_variants
    gift_card_product_ids = Product.not_deleted.where(["is_gift_card = ?", true]).map(&:id)
    @gift_card_variants = Variant.where(["price > 0 AND product_id IN (?)", gift_card_product_ids]).order("price")
  end
end
