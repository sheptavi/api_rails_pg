module Api
  module V1
    class AppliesController < ApplicationController
      before_action :set_apply, only: [:show, :update, :destroy]

      # GET /api/v1/applies
      # GET /api/v1/jobs/:job_id/applies
      # GET /api/v1/geeks/:geek_id/applies
      def index
        if params[:job_id]
          @applies = Apply.includes(:job, :geek)
        elsif params[:geek_id]
          @applies = Geek.find(params[:geek_id]).applies
        else
          @applies = Apply.all
        end
        @applies = @applies.where(read: params[:read]) if params[:read].present?
        @applies = @applies.where(invited: params[:invited]) if params[:invited].present?
        @applies = paginate(@applies)

        render json: {
          applies: @applies,
          meta: {
            current_page: @applies.current_page,
            total_pages: @applies.total_pages,
            total_count: @applies.total_count,
            per_page: @applies.limit_value
          }
        }
      end

      # GET /api/v1/applies/:id
      def show
        render json: { apply: @apply }
      end

      # POST /api/v1/applies
      def create
        @apply = Apply.new(apply_params)
        if @apply.save
          render json: { apply: @apply }, status: :created
        else
          render json: { errors: @apply.errors }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/applies/:id
      def update
        if @apply.update(apply_params)
          render json: { apply: @apply }
        else
          render json: { errors: @apply.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/applies/:id
      def destroy
        @apply.destroy
        render json: { message: 'Заявление удалено' }
      end

      private

      def set_apply
        @apply = Apply.find(params[:id])
      end

      def apply_params
        params.require(:apply).permit(:job_id, :geek_id, :read, :invited)
      end
    end
  end
end