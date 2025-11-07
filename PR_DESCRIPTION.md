# Ajout des codes C3 à C80 dans le dictionnaire

## 📋 Description

Cette PR complète le fichier `specs/dictionnary.yml` en ajoutant tous les codes manquants de C3 à C80, avec leurs labels, types, enums et règles de validation appropriées.

## ✨ Changements

### Ajout des codes C3 à C80
- **78 nouveaux codes** ajoutés au dictionnaire
- Chaque code inclut :
  - Un `label` descriptif en snake_case
  - Un `type` (string ou integer selon le contexte)
  - Un `enum` avec au minimum `"0": "ND"`
  - Un attribut `required` (true par défaut, false pour les codes se terminant par une lettre)

### Types de données
- **Type string** : pour les champs textuels et les enums avec valeurs multiples
- **Type integer** : pour les champs numériques (poids, dimensions, dates, valeurs nutritionnelles, etc.)

### Codes avec `required: false`
Les codes suivants se terminent par une lettre et ont donc `required: false` :
- C32A (batch_number)
- C33B (traceability_number)
- C37C (bottle_barcode_number)
- C39D (case_barcode_number)
- C52E (specific_back_label_BAT)
- C53F (technical_sheet_url)
- C54G (export_analysis_url)
- C55H (certificate_url)
- C56I (photos_url)
- C57J (packaging_visual_url)
- C58K (certificate_origin_url)
- C63L (fda)
- C64M (gacc)
- C65N (ttb)
- C67O (list_of_ingredient)
- C77P (qr_code_url)

### Enums enrichis
Plusieurs codes ont été enrichis avec des valeurs d'enum supplémentaires au-delà de `"0": "ND"`, notamment :
- C3 (case_characteristic) : 8 valeurs
- C4 (case_origin) : 4 valeurs
- C5 (case_packaging) : 11 valeurs
- C11 (vintage) : 1 valeur ("Sans millésime")
- C13 (bottle_size) : 28 valeurs de volumes
- C14 (traffic_right) : 4 valeurs
- C20 (logo_packaging) : 12 valeurs
- C21 (bottle_packaging) : 6 valeurs
- C26 (reward_type) : 11 valeurs
- C27 (competition) : 24 valeurs
- C29 (bottle_packaging_reward) : 11 valeurs
- C30 (capping) : 9 valeurs
- C36 (bottle_barcode_origin) : 5 valeurs
- C37C (bottle_barcode_number) : 5 valeurs
- C38 (case_barcode_origin) : 5 valeurs
- C39D (case_barcode_number) : 5 valeurs
- C40 (vintage_certification_organism) : 25 valeurs
- C41 (vintage_agriculture) : 33 valeurs
- C43 (packaging_certification) : 5 valeurs
- C44 (estate_certification_organism) : 10 valeurs
- C45 (estate_certificate) : 12 valeurs
- C47 (packaging_estate_certification) : 4 valeurs
- C48 (sulphite) : 2 valeurs
- C49 (sulphites_language) : 18 valeurs
- C50 (back_label_language) : 24 valeurs
- C51 (pass_presence) : 2 valeurs
- C52E (specific_back_label_BAT) : 6 valeurs
- C59 (pallet_type) : 6 valeurs
- C63L (fda) : 2 valeurs
- C67O (list_of_ingredient) : 2 valeurs
- C76 (qr_code_nutri_info) : 3 valeurs
- C77P (qr_code_url) : 28 valeurs (tailles de bouteilles)
- C79 (case_available) : 2 valeurs

### Cas particuliers
- **C10 (product)** : Pas d'enum défini (champ libre)
- **C11 (vintage)** : Enum modifié pour inclure uniquement "Sans millésime" au lieu de "ND"

## 📊 Statistiques

- **Codes ajoutés** : 78 (C3 à C80)
- **Total de codes** : 81 (C0 à C80)
- **Codes avec enums enrichis** : ~30 codes
- **Codes avec type integer** : ~20 codes (dimensions, poids, dates, valeurs nutritionnelles)

## ✅ Validation

- [x] Tous les codes C3 à C80 sont présents
- [x] Les types sont correctement définis (string/integer)
- [x] Les codes se terminant par une lettre ont `required: false`
- [x] Les enums incluent au minimum `"0": "ND"`
- [x] Le fichier YAML est syntaxiquement correct

## 🔗 Fichiers modifiés

- `specs/dictionnary.yml` : Ajout des codes C3 à C80 avec leurs configurations complètes

