# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "275375345884782", "d55297abfb19cfc4ed3d2cf87bd684d8"
end
