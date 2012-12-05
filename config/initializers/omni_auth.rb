# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '148263508630116', '495ddfd26e18692f46a2a9313e38ad7f'
end
