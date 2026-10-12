class JobSerializer < ActiveModel::Serializer
  attributes :id, :name, :place, :company_id

  belongs_to :company
  has_many :applies
end