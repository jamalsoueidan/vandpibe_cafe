ActiveAdmin.register Reference do
  menu :parent => "Countries"

  controller do
    def permitted_params
      params.permit(:reference => [:location_id, :name, :link])
    end
  end
end
