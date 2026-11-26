module Types
  class QueryType < Types::BaseObject
    # 1. Тестовое поле
    field :test_field, String, null: false
    def test_field
      'Hello World!'
    end

    # 2. Получить все компании
    field :all_companies, [Types::CompanyType], null: false
    def all_companies
      Company.all
    end

    # 3. Получить одну компанию по ID
    field :company, Types::CompanyType, null: true do
      argument :id, ID, required: true
    end
    def company(id:)
      Company.find(id)
    end

    # 4. Получить все вакансии
    field :all_jobs, [Types::JobType], null: false
    def all_jobs
      Job.all
    end
  end
end