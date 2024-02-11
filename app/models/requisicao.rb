class Requisicao < ApplicationRecord
  # Associations
  belongs_to :estoque

  # Validations
  validates :tipo, :data, :numero, :setor, :estoque, presence: true
  validates :quantidade, :custo_medio, :custo_total, numericality: true

  # Enumerators
  enum tipo: [:'Requisição', :'Devolução']
  enum tipo: [:'Matérias-Primas', :'Componentes', :'Equipamentos e Ferramentas', :'Produtos Semi-acabados', :'Produtos Acabados']

  # Callback
  after_create :after_create_requisicao
  after_destroy :after_destroy_requisicao

  # Methods Privates
  private

  def after_create_requisicao

    if self.tipo == "Requisição"
      self.update(custo_medio: self.estoque.custo_medio, custo_total: (self.quantidade * self.estoque.custo_medio))
      estoque_saldo = self.estoque.estoque_saldo - self.quantidade
      custo_total = estoque_saldo * custo_medio
      self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
    elsif
    self.update(custo_medio: self.estoque.custo_medio, custo_total: (self.quantidade * self.estoque.custo_medio))
      estoque_saldo = self.estoque.estoque_saldo + self.quantidade
      custo_total = estoque_saldo * custo_medio
      self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
    end

  end

  def after_destroy_requisicao

    if self.tipo == "Requisição"
      estoque_saldo = self.estoque.estoque_saldo + self.quantidade
      custo_total = estoque_saldo * custo_medio
      self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
    elsif (estoque_saldo = self.estoque.estoque_saldo - self.quantidade)
      custo_total = estoque_saldo * custo_medio
      self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
    end

  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at custo_medio custo_total data estoque_id id id_value numero observacoes quantidade setor tipo updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["estoque"]
  end

end
