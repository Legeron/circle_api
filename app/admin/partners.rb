ActiveAdmin.register Partner do
  permit_params :name, :code

  actions :all, except: []

  filter :id
  filter :name
  filter :code
  filter :auth_token
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :code
    column :auth_token
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table_for(resource) do
      row :id
      row :name
      row :code
      row :auth_token
      row :created_at
      row :updated_at
    end

    panel "Identifier Pairs" do
      table_for resource.identifier_pairs do
        column :id
        column :my_alias
        column :partner_alias
        column :active
        column :created_at
        column :updated_at
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :code
      f.input :auth_token, input_html: { disabled: true, readonly: true } if f.object.persisted?
    end
    f.actions
  end
end
