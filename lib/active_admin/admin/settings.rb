ActiveAdmin.register Setting do
  
  actions :all, :except => [:destroy]
  
  index do
    selectable_column
    column :name
    column :description
    column :value
    column :encrypted
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :value, :input_html => {:value => setting.value}
      f.input(
        :encrypted, 
        :input_html => {
          :checked => (setting.encrypted == false ? false : true)
        }
      )
    end
    f.buttons
  end
  
end
