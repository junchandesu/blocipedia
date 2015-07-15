class ChargesController < ApplicationController 

   def new
     @stripe_btn_data = {
       key: "#{ Rails.configuration.stripe[:publishable_key] }",
       description: "BigMoney Membership - #{current_user.name}",
       amount:  @default_amount 
     }
     @default_amount = 150_00
   end


   def downgrade
      current_user.role = "standard"
      current_user.save!
      current_user.wikis.each do |wiki|
        wiki.update_attribute(:private, false)
      end
     redirect_to root_path
      
    end

  def create
    @default_amount = 150_00
   # Creates a Stripe Customer object, for associating
   # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
      )
 
   # Where the real magic happens
    charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount:  @default_amount, 
       description: "BigMoney Membership - #{current_user.email}",
       currency: 'usd'
     )
    current_user.update_attributes(role: "premium")
    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever


   

 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
   end

end