class TestMailer < ActionMailer::Base
  default from: "jamal@soueidan.com"
  
  def contact(params)
    @params = params
    mail(:to => 'jamalsoueidan@me.com', :subject => 'Kontakt os')
  end
end
