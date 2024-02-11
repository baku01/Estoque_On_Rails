class Ability
  include CanCan::Ability

  def initialize(usuario)
    if usuario
      if usuario.perfil == 'Colaborador'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :manage, Entrada
        can :manage, Requisicao
        can :read, Grupo
        can :read, Estoque
      elsif usuario.perfil == 'Encarregado'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :manage, Entrada
        can :manage, Requisicao
        can :manage, Estoque
        can :manage, Grupo
      elsif usuario.perfil == 'Administrador'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :manage, Usuario
        can :read, Grupo
        can :read, Estoque
        can :read, Entrada
        can :read, Requisicao
      end
    end
  end

end
