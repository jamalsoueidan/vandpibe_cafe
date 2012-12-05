ActiveAdmin.register Upload do  
  menu false
  
  form do |f|
    f.inputs "Details" do
      f.input :avatar, :as => :file
      f.input :title
      f.input :uploadable_id, :as => :hidden, :input_html => {:value => params[:location_id]}
      f.input :uploadable_type, :as => :hidden, :input_html => {:value => 'Location'}
    end
    f.buttons
  end
  
  member_action :create, :method => :post do
    flash[:notice] = 'Upload was successfully created.'
    @upload = Upload.new(params[:upload])
    if @upload.save
      redirect_to admin_location_path(:id => @upload.uploadable_id)
    end
  end
  
  member_action :destroy, :method => :delete do
    flash[:notice] = 'Upload was successfully destroyed.'
    upload = Upload.find(params[:id])
    upload.delete
    redirect_to admin_location_path(:id => upload.uploadable_id)
  end
end
