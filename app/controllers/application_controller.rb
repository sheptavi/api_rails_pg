class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Запись не найдена', status: :not_found }, status: :not_found
  end

  rescue_from ActionController::RoutingError do |exception|
    logger.error "Ошибка маршрута: #{exception}"
    render json: { error: 'Маршрут не найден', status: :no_route }, status: :not_found
  end

  def catch_404
    raise ActionController::RoutingError.new(params[:path])
  end

  private

  def paginate(collection)
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 25
    per_page = [per_page, 100].min
    collection.page(page).per(per_page)
  end
end