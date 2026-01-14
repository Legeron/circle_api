# app/services/validations/match_other_code_length_validation.rb
require_relative "base_validation"

module Validations
  class MatchOtherCodeLengthValidation < BaseValidation
    def validate
      source_code = rule["source_code"]
      source_value = circle_values[source_code]

      # Si le source_code n'existe pas ou n'est pas un array, pas de validation
      return nil unless source_value.is_a?(Array)

      # Si le source_code est un array, alors le code actuel doit aussi être un array
      unless value.is_a?(Array)
        return "Si #{source_code} est un array, alors #{code} doit aussi être un array (valeur reçue : '#{value}')."
      end

      # Vérifier que les deux arrays ont la même longueur
      if source_value.length != value.length
        return "#{code} doit avoir le même nombre de valeurs que #{source_code} (#{source_code}: #{source_value.length} valeur(s), #{code}: #{value.length} valeur(s))."
      end

      nil
    end

    def default_error_message(code)
      "Erreur de match_other_code_length sur #{code}."
    end
  end
end
