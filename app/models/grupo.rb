class Grupo < ApplicationRecord
  # Associations
  has_many :estoques

  # Validations
  validates :nome, :status, presence: true

  # Enumerators
  enum status: [:Ativo, :Inativo]

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id id_value nome status updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["estoques"]
  end

  # Virtual Attributes
  def to_s
    "#{nome}"
  end
end
