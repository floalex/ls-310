require 'rails_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge, :vcr do
    it "makes a successful charge" do
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      token = Stripe::Token.create(
        card: {
         number: "4242424242424242",
         exp_month: 5,
         exp_year: 2018,
         cvc: "314"
       }
      ).id
      
      response = StripeWrapper::Charge.create(
        amount: 999,
        description: "A Valid Charge",
        card: token
      )
      
      expect(response.amount).to eq(999)
      expect(response.currency).to eq('usd')
    end
  end
end