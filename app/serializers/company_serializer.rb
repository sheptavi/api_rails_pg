class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :deleted

  has_many :jobs
end