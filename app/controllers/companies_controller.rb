class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.create(company_params)
    if @company.valid?
      redirect_to companies_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :user_id)
  end
end
