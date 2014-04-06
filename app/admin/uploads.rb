ActiveAdmin.register Upload do  
  menu false
  
  form do |f|
    f.inputs "Details" do
      f.input :avatar, :as => :file
      f.input :title
      f.input :uploadable_id, :as => :hidden, :input_html => {:value => params[:uploadable_id]}
      f.input :uploadable_type, :as => :hidden, :input_html => {:value => params[:uploadable_type]}     
    end
    f.actions
  end
  
  member_action :create, :method => :post do
    flash[:notice] = 'Upload was successfully created.'
    @upload = Upload.new(upload_params)
    if @upload.save
      redirect_to :back
      #redirect_to admin_location_path(:id => @upload.uploadable_id)
    end
  end
  
  member_action :destroy, :method => :delete do
    flash[:notice] = 'Upload was successfully destroyed.'
    upload = Upload.find(params[:id])
    upload.destroy
    name = upload.uploadable_type.singularize.downcase
    uri = send("admin_" + name + "_path", upload.uploadable_id)
    redirect_to uri
  end

  controller do
    def upload_params
      params.require(:upload).permit(:avatar, :title, :uploadable_id, :uploadable_type)
    end
  end
end
