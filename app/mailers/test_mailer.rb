class TestMailer < ActionMailer::Base
  default from: "jamal@soueidan.com"
  
  def step2(email)
    mail(:to => email, :subject => "Step 2")
  end
  
  def step3(email)
    mail(:to => email, :subject => "Step 3")    
  end
  
  def contact(params)
    @params = params
    mail(:to => 'jamalsoueidan@me.com', :subject => 'Kontakt os')
  end
end
