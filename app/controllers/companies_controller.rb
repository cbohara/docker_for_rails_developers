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
    return render_not_found if @company.blank?
  end

  def edit
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?
  end

  def update
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?

    @company.update_attributes(company_params)

    if @company.valid?
      redirect_to companies_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?

    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :user_id)
  end

  def render_not_found
    render text: "Not Found", status: :not_found
  end
end
