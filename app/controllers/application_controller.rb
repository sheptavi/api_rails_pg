class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render json: {
      error: 'Запись не найдена в базе данных',
      status: :not_found
    }, status: :not_found
  end

  rescue_from ActionController::RoutingError do |exception|
    logger.error "Ошибка маршрута: #{exception}"
    render json: {
      error: 'Маршрут не найден',
      status: :no_route
    }, status: :not_found
  end

  def catch_404
    raise ActionController::RoutingError.new(params[:path])
  end
end