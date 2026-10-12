module Api
  module V1
    class GeeksController < ApplicationController
      before_action :set_geek, only: [:show, :update, :destroy]

      # GET /api/v1/geeks
      def index
        @geeks = Geek.includes(:applies)
        @geeks = @geeks.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
        @geeks = @geeks.where("stack ILIKE ?", "%#{params[:stack]}%") if params[:stack].present?
        @geeks = paginate(@geeks)

        render json: {
          geeks: @geeks,
          meta: {
            current_page: @geeks.current_page,
            total_pages: @geeks.total_pages,
            total_count: @geeks.total_count,
            per_page: @geeks.limit_value
          }
        }
      end

      # GET /api/v1/geeks/:id
      def show
        render json: { geek: @geek }
      end

      # POST /api/v1/geeks
      def create
        @geek = Geek.new(geek_params)
        if @geek.save
          render json: { geek: @geek }, status: :created
        else
          render json: { errors: @geek.errors }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/geeks/:id
      def update
        if @geek.update(geek_params)
          render json: { geek: @geek }
        else
          render json: { errors: @geek.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/geeks/:id
      def destroy
        @geek.destroy
        render json: { message: 'Соискатель удалён' }
      end

      private

      def set_geek
        @geek = Geek.find(params[:id])
      end

      def geek_params
        params.require(:geek).permit(:name, :stack, :resume)
      end
    end
  end
end