class GeekSerializer < ActiveModel::Serializer
  attributes :id, :name, :stack, :resume

  has_many :applies
end