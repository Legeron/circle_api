# app/policies/order_status_policy.rb
# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  BUYER_ONLY  = %w[
    demande_de_mise_et_logistique_en_cours
    details_de_mise_et_logistique_confirmes
    commande_cloturee
  ].freeze

  SELLER_ONLY = %w[
    nouvelle_commande
    en_attente_demande_de_mise
    bon_de_commande
    mise_a_disposition
    bon_de_livraison
  ].freeze

  ALLOWED_TRANSITIONS = {
    "nouvelle_commande"                       => %w[en_attente_demande_de_mise],
    "en_attente_demande_de_mise"             => %w[demande_de_mise_et_logistique_en_cours details_de_mise_et_logistique_confirmes],
    "demande_de_mise_et_logistique_en_cours" => %w[details_de_mise_et_logistique_confirmes],
    "details_de_mise_et_logistique_confirmes"=> %w[bon_de_commande],
    "bon_de_commande"                         => %w[mise_a_disposition],
    "mise_a_disposition"                      => %w[bon_de_livraison],
    "bon_de_livraison"                        => %w[commande_cloturee]
  }.freeze

  # Autorisation "générale" d'action
  def create?
    # Vérifier que le user authentifié est le buyer
    true
  end

  def update?
    true
  end

  # Vérifie que la transition d'état demandée est autorisée
  # to_status: String (ex: "bon_de_commande")
  def transition?(to_status)
    from = record&.status.presence || "nouvelle_commande"
    allowed = ALLOWED_TRANSITIONS.fetch(from, [])
    return false unless allowed.include?(to_status)

    case actor_role_for(user, record)
    when :buyer  then BUYER_ONLY.include?(to_status)
    when :seller then SELLER_ONLY.include?(to_status)
    else false
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      # Filtrer les commandes visibles par l'utilisateur authentifié'
      scope
    end
  end

  private

  # Déduis le rôle effectif de l'acteur sur CETTE commande
  # Implémente ici ta logique: appariement clé API ↔ paire buyer/seller, etc.
  def actor_role_for(user, order)
    # Retrouner le rôle de l'utilisateur authentifié dans la commande (buyer ou seller)
  end
end
