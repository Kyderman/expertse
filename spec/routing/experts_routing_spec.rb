require "spec_helper"

describe ExpertsController do
  describe "routing" do

    it "routes to #index" do
      get("/experts").should route_to("experts#index")
    end

    it "routes to #new" do
      get("/experts/new").should route_to("experts#new")
    end

    it "routes to #show" do
      get("/experts/1").should route_to("experts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/experts/1/edit").should route_to("experts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/experts").should route_to("experts#create")
    end

    it "routes to #update" do
      put("/experts/1").should route_to("experts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/experts/1").should route_to("experts#destroy", :id => "1")
    end

  end
end
