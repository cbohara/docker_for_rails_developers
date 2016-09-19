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

    it "should check for validation errors" do
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
    it "should require users to be logged in" do
      company = FactoryGirl.create(:company)
      get :edit, id: company.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show edit form if company is found" do
      company = FactoryGirl.create(:company)
      sign_in company.user

      get :edit, id: company.id
      expect(response).to have_http_status(:success)
    end

    it "should return 404 error if company is not found" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :edit, id: 'NOPE'
      expect(response).to have_http_status(:not_found)
    end

    it "should only allow user who created company post to edit post" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user)
      sign_in user

      get :edit, id: company.id
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "companies#update action" do
    it "should require users to be logged in" do
      company = FactoryGirl.create(:company)
      patch :update, id: company.id, company: {name: 'Changed'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update company info" do
      company = FactoryGirl.create(:company, name: 'Initial')
      sign_in company.user

      patch :update, id: company.id, company: {name: 'Changed'}
      expect(response).to redirect_to companies_path

      company.reload
      expect(company.name).to eq 'Changed'

    end

    it "should return 404 error if company is not found" do
      user = FactoryGirl.create(:user)
      sign_in user

      patch :update, id: 'NOPE'
      expect(response).to have_http_status(:not_found)
    end

    it "should check for validation errors" do
      company = FactoryGirl.create(:company, name: 'Initial')
      sign_in company.user

      patch :update, id: company.id, company: {name: ' '}
      expect(response).to have_http_status(:unprocessable_entity)

      company.reload
      expect(company.name).to eq 'Initial'
    end

    it "should only allow user who made the company post to update the post" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user)
      sign_in user

      patch :update, id: company.id, company: {name: company.name}
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "companies#destroy action" do
    it "should require users to be logged in" do
      company = FactoryGirl.create(:company)
      delete :destroy, id: company.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to destroy a company" do
      company = FactoryGirl.create(:company)
      sign_in company.user

      delete :destroy, id: company.id

      expect(response).to redirect_to companies_path

      search = Company.find_by_id(company.id)
      expect(search).to eq nil
    end

    it "should return 404 error if company is not found" do
      user = FactoryGirl.create(:user)
      sign_in user

      delete :destroy, id: 'NOPE'
      expect(response).to have_http_status(:not_found)
    end

    it "should only allow the user who created the company post to delete the post" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user)
      sign_in user

      delete :destroy, id: company.id
      expect(response).to have_http_status(:forbidden)
    end
  end
end
