class ApplySerializer < ActiveModel::Serializer
  attributes :id, :read, :invited, :job_id, :geek_id

  belongs_to :job
  belongs_to :geek
end