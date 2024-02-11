class Estoque < ApplicationRecord
  # Associations
  belongs_to :grupo
  has_many :entradas
  has_many :requisicao

  # Validations
  validates :tipo, :descricao, :unidade, :estoque_minimo, :estoque_maximo, :estoque_reposicao, :status, :grupo, presence: true
  validates :estoque_minimo, :estoque_maximo, :estoque_reposicao, :estoque_saldo, :custo_medio, :custo_total, numericality: true

  # Enumerators
  enum tipo: [:'Alimentos e Bebidas', :'Diversos']
  enum status: [:Ativo, :Inativo]

  def self.ransackable_attributes(auth_object = nil)
    %w[codigo conta_contabil created_at custo_medio custo_total descricao estoque_maximo estoque_minimo estoque_reposicao estoque_saldo grupo_id id id_value localizacao perecivel status tipo unidade updated_at]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[entradas grupo requisicao]
  end


  # Virtual Attributes
  def to_s
    "#{descricao}"
  end
end
