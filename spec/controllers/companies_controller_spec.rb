require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe "companies#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "companies#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show a new form" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "companies#create action" do
    it "should require users to be logged in" do
      company = FactoryGirl.create(:company)
      post :create, company: {name: company.name}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new company in our database" do
      user = FactoryGirl.create(:user)
      sign_in user

      company = FactoryGirl.create(:company)
      post :create, company: {name: company.name}
      expect(response).to redirect_to companies_path

      company = Company.last
      expect(company.name).to eq("Starbucks")
      expect(company.user).to eq(user)
    end

    it "should deal with validation errors" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, company: {name: " "}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Company.count).to eq Company.count
    end
  end

  describe "companies#show action" do
    it "should show the correct company show page based on company id" do
      company = FactoryGirl.create(:company)
      get :show, id: company.id
      expect(response).to have_http_status(:success)
    end

    it "should return 404 error if company is not found" do
      get :show, id: 'NOPE'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "companies#edit action" do
    it "should successfully show the edit form if the company is found" do
      company = FactoryGirl.create(:company)
      get :edit, id: company.id
      expect(response).to have_http_status(:success)
    end

    it "should return 404 error if company is not found" do
      get :edit, id: 'NOPE'
      expect(response).to have_http_status(:not_found)
    end
  end
end
