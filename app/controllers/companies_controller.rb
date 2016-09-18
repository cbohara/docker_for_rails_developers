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

  def show
    @company = Company.find_by_id(params[:id])
    if @company.blank?
      render text: "Not Found", status: :not_found
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :user_id)
  end
end
