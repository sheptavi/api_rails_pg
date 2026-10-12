module Api
  module V1
    class JobsController < ApplicationController
      before_action :set_job, only: [:show, :update, :destroy]

      # GET /api/v1/jobs
      # GET /api/v1/companies/:company_id/jobs
      def index
        if params[:company_id]
          @jobs = Job.includes(:company, :applies)
        else
          @jobs = Job.all
        end
        @jobs = @jobs.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
        @jobs = @jobs.where("place ILIKE ?", "%#{params[:place]}%") if params[:place].present?
        @jobs = paginate(@jobs)

        render json: {
          jobs: @jobs,
          meta: {
            current_page: @jobs.current_page,
            total_pages: @jobs.total_pages,
            total_count: @jobs.total_count,
            per_page: @jobs.limit_value
          }
        }
      end

      # GET /api/v1/jobs/:id
      def show
        render json: { job: @job }
      end

      # POST /api/v1/jobs
      def create
        @job = Job.new(job_params)
        if @job.save
          render json: { job: @job }, status: :created
        else
          render json: { errors: @job.errors }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/jobs/:id
      def update
        if @job.update(job_params)
          render json: { job: @job }
        else
          render json: { errors: @job.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/jobs/:id
      def destroy
        @job.destroy
        render json: { message: 'Вакансия удалена' }
      end

      private

      def set_job
        @job = Job.find(params[:id])
      end

      def job_params
        params.require(:job).permit(:name, :place, :company_id)
      end
    end
  end
end