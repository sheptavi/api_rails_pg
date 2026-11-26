class ApiRailsPgSchema < GraphQL::Schema
  # Ловушка для ошибки, если запись не найдена
  rescue_from(ActiveRecord::RecordNotFound) { 'Not found' }
  
  # Указываем, где лежат наши запросы
  query Types::QueryType
end