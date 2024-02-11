class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  validates :nome, :perfil, :status, presence: true
  enum perfil: [:Colaborador, :Encarregado, :Administrador]
  enum status: [:Ativo, :Inativo]

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at email id nome perfil remember_created_at  status updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end


end
