require 'rails_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items for the signed in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      # set the @queue_items to the array
      expect(assigns[:queue_items]).to match_array([queue_item1, queue_item2])
    end
    
    it "redirects to the sign in page for the unauthenticated user" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  
end