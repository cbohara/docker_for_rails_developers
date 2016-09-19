class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.create(company_params)
    if @company.valid?
      return redirect_to companies_path
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def show
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?
  end

  def edit
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?
    return render_not_found(:forbidden) if @company.user != current_user
  end

  def update
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?
    return render_not_found(:forbidden) if @company.user != current_user

    @company.update_attributes(company_params)

    if @company.valid?
      return redirect_to companies_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company = Company.find_by_id(params[:id])
    return render_not_found if @company.blank?
    return render_not_found(:forbidden) if @company.user != current_user
    
    @company.destroy
    return redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :user_id)
  end

  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize}", status: status
  end
end
