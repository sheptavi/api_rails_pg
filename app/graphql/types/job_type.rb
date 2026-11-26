module Types
  class JobType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :place, String, null: true
    field :company_id, ID, null: false
  end
end