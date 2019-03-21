# frozen_string_literal: true

RSpec.describe ShoppingCart::CouponsController, type: :controller do
  routes { ShoppingCart::Engine.routes }

  let(:user) { create(:user) }
  let(:order) { create(:shopping_cart_order, user: user) }
  let(:coupon) { create(:shopping_cart_coupon, order: order) }
  let(:unused_coupon) { create(:shopping_cart_coupon) }
  let(:invalid_coupon) { attributes_for(:shopping_cart_coupon, :invalid) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'POST #create' do
    context 'coupon does not exist' do
      before do
        post :create, params: { coupon: invalid_coupon,
                                locale: I18n.locale }
      end

      it 'redirects to cart page' do
        expect(response).to redirect_to(cart_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq I18n.t('coupon.not_exist')
      end
    end

    context 'coupon used' do
      before do
        post :create, params: { coupon: { code: coupon.code },
                                locale: I18n.locale }
      end

      it 'redirect to cart page' do
        expect(response).to redirect_to(cart_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq I18n.t('coupon.used')
      end
    end

    context 'with valid params' do
      before do
        post :create, params: { coupon: { code: unused_coupon.code },
                                locale: I18n.locale }
      end

      it 'relates coupon with order' do
        expect(ShoppingCart::Coupon.find(unused_coupon.id).order).not_to be_nil
      end

      it 'redirects to cart page' do
        expect(response).to redirect_to(cart_path)
      end

      it 'sends notice' do
        expect(flash[:notice]).to eq I18n.t('coupon.added')
      end
    end
  end
end
