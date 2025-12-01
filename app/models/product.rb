class Product
  require "csv"

  attr_reader :family,
              :product_type,
              :product_complement,
              :country,
              :region,
              :subregion,
              :origin_sign,
              :origin,
              :mention,
              :name,
              :label_complement,
              :label,
              :classification,
              :classification_detail,
              :bottler,
              :color,
              :starting_vintage,
              :late_vintage,
              :excluded_vintages,
              :code

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def vintage_allowed?(vintage)
    vintage_int = vintage.to_i
    return false if excluded_vintages.include?(vintage_int)
    return false if vintage_int < @starting_vintage
    return false if vintage_int > @late_vintage
    return false if vintage_int > Date.today.year
    true
  end

  def c10
    code
  end

  def self.all
    load_products.values
  end

  def self.find_by(c10:)
    load_products[c10]
  end

  private

  def self.load_products
    @products ||= begin
      path = Rails.root.join("specs", "products.csv")
      rows = CSV.read(path, headers: true)

      rows.each_with_object({}) do |row, hash|
        c10 = row["C10"]
        next if c10.blank?

        attributes = {
          code: c10, # C10
          label: row["Etiquette"],
          starting_vintage: self.normalize_starting_vintage(row["Premier millésime"]),
          late_vintage: self.normalize_late_vintage(row["Dernier Millésime"]),
          excluded_vintages: self.write_excluded_vintages_from_range(row["Millésime(s) non produit(s)"]),
          family: row["Famille"],
          product_type: row["Type produit"],
          product_complement: row["Complément Produit"],
          country: row["Pays"],
          region: row["Région"],
          subregion: row["Sous-Région"],
          origin_sign: row["Signe de l'Origine"],
          origin: row["Origine"],
          mention: row["Mention"],
          name: row["Nom"],
          label_complement: row["Complément étiquette / Cuvée"],
          classification: row["Classement / Appellation"],
          classification_detail: row["Du Classement / Climat"],
          bottler: row["Producteur / Embouteilleur"],
          color: row["Couleur"]
        }

        product = new(attributes)

        hash[c10] = product
      end
    end
  end

  def self.normalize_starting_vintage(vintage)
    return 1855 if vintage.nil? || vintage.to_s.strip == "ND" || vintage.to_s.strip.empty?
    vintage.to_i
  end

  def self.normalize_late_vintage(vintage)
    return Date.today.year if vintage.nil? || vintage.to_s.strip == "ND" || vintage.to_s.strip.empty?
    vintage.to_i
  end

  def self.write_excluded_vintages_from_range(excluded_vintages)
    return [] if excluded_vintages.nil? ||
                excluded_vintages.to_s.strip.empty? ||
                excluded_vintages.to_s.strip == "ND"

    # Normaliser en array si c'est une string
    ranges = if excluded_vintages.is_a?(Array)
      excluded_vintages
    else
      excluded_vintages.to_s.split(",").map(&:strip)
    end

    # Parser chaque élément (peut être une plage "2003-2007" ou une année "2013")
    ranges.flat_map do |range_str|
      range_str = range_str.strip
      next [] if range_str.empty?

      if range_str.include?("-")
        # C'est une plage : "2003-2007"
        start_year, end_year = range_str.split("-").map(&:strip).map(&:to_i)
        (start_year..end_year).to_a
      else
        # C'est une année unique : "2013"
        [ range_str.to_i ]
      end
    end.compact
  end
end
