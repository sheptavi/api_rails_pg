module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: [:show, :update, :destroy, :mark_deleted]

      # GET /api/v1/companies
      def index
        @companies = Company.where(deleted: false)
        @companies = @companies.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
        @companies = @companies.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
        render json: { companies: @companies }
      end

      # GET /api/v1/companies/:id
      def show
        render json: { company: @company }
      end

      # POST /api/v1/companies
      def create
        @company = Company.new(company_params)
        if @company.save
          render json: { company: @company }, status: :created
        else
          render json: { errors: @company.errors }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/companies/:id
      def update
        if @company.update(company_params)
          render json: { company: @company }
        else
          render json: { errors: @company.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/companies/:id
      def destroy
        @company.update(deleted: true)
        render json: { message: 'Компания помечена как удалённая', company: @company }
      end

      # PUT /api/v1/companies/:id/mark_deleted
      def mark_deleted
        if @company.deleted
          render json: { message: 'Уже удалена' }, status: :not_modified
        else
          @company.update(deleted: true)
          render json: { company: @company, status: :success }
        end
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(:name, :location)
      end
    end
  end
end