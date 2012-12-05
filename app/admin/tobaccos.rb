ActiveAdmin.register Tobacco do
  form do |f|
      f.inputs do
        f.input :name
        f.input :brand
        f.input :locations, :input_html => {:size => 40}
      end
      f.buttons
    end
  
end
