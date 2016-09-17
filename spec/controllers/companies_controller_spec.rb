require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe "companies#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "companies#new action" do
    it "should successfully show a new form" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "companies#create action" do
    it "should successfully create a new company in our database" do
      post :create, company: {name: "Starbucks"}
      expect(response).to redirect_to companies_path

      company = Company.last
      expect(company.name).to eq("Starbucks")
    end
  end
end
