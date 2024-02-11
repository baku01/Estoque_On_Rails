class Entrada < ApplicationRecord
  # Associations
  belongs_to :estoque

  # Validations
  validates :data, :documento, :numero, :quantidade, :preco_unitario, :preco_total, :estoque, presence: true
  validates :quantidade, :preco_unitario, :preco_total, numericality: true

  # Callback
  after_create :after_create_entrada
  after_destroy :after_destroy_entrada

  # Methods Privates
  private

  def after_create_entrada
    preco_total = self.quantidade * self.preco_unitario
    self.update(preco_total: preco_total)
    custo_medio = (((self.estoque.estoque_saldo * self.preco_unitario) + (self.quantidade * self.preco_unitario)) / (self.estoque.estoque_saldo + self.quantidade))
    estoque_saldo = self.estoque.estoque_saldo + self.quantidade
    custo_total = estoque_saldo * custo_medio
    self.estoque.update(custo_medio: custo_medio, estoque_saldo: estoque_saldo, custo_total: custo_total)
  end

  def after_destroy_entrada
    estoque_saldo = self.estoque.estoque_saldo - self.quantidade
    custo_total = estoque_saldo * self.estoque.custo_medio
    self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[codigo conta_contabil created_at custo_medio custo_total descricao estoque_maximo estoque_minimo estoque_reposicao estoque_saldo grupo_id id id_value localizacao perecivel status tipo unidade updated_at numero]
  end

  def self.ransackable_associations(auth_object = nil)
    ["estoque"]
  end


end
