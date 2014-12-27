class StaticPagesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
  end

  def charge
	# Set your secret key: remember to change this to your live secret key in production
	# See your keys here https://dashboard.stripe.com/account
	Stripe.api_key = ENV['STRIPE_API_KEY']

	# Get the credit card details submitted by the form
	token = params[:stripeToken]

	# Create the charge on Stripe's servers - this will charge the user's card
	begin
	  charge = Stripe::Charge.create(
	    :amount => params[:payments][:cost], # amount in cents, again
	    :currency => "gbp",
	    :card => token,
	    :description => "payinguser@example.com"
	  )
	rescue Stripe::CardError => e
	  # The card has been declined
	end
  end

end
