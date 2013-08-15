ActiveAdmin.register Product do
  index do       
    column :id
    column :title do |product|
      div do
        link_to product.title, admin_product_path(product)
      end
    end
    column :variant
  end
  
  show do
    attributes_table do
      row :id
      row :title
      row :stock
    end
    
    panel "List of images" do
      
      if product.uploads.empty?
        strong { raw 'No image added!<br /><br />'}
      else
        table_for product.uploads do 
          column :avatar do |upload| 
            image_tag upload.avatar.url(:thumb)
          end
          column :remove do |upload|
            span { link_to 'Remove', admin_upload_path(upload), :method => :delete, :confirm => "Are you sure?" }
          end
        end
      end
      
      div do
        render "footer"
      end
      
    end
  end

  controller do
    def permitted_params
      params.permit(:product => [:title, :brand, :variant_id, :short_desc, :long_desc, :price, :stock])
    end
  end
end
