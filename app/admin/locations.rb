ActiveAdmin.register Location do  
  index do       
    column :name do |location|
      div do
        link_to location.name, admin_location_path(location)
      end
    end
  end
  
  show do
    attributes_table do
      row :id
      row :name
    end
    
    panel "List of images" do
      
      if location.uploads.empty?
        strong { raw 'No image added!<br /><br />'}
      else
        table_for location.uploads do 
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
end
