class TestMailer < ActionMailer::Base
  default from: "jamal@soueidan.com"
  
  def step1
    mail(:to => ['js@movis.dk', 'jamal.soueidan@gmail.com', 'test@soueidan.com', 'memo05@live.dk'], :subject => "Toyota - Step 1 - " + Random.new.rand(1..10000).to_s)
  end
  
  def step2
    mail(:to => ['js@movis.dk', 'jamal.soueidan@gmail.com', 'test@soueidan.com', 'memo05@live.dk'], :subject => "Toyota - step 2 - " + Random.new.rand(1..10000).to_s)
  end
  
  def step3
    mail(:to => ['js@movis.dk', 'jamal.soueidan@gmail.com', 'test@soueidan.com', 'memo05@live.dk'], :subject => "Toyota - step 3 - " + Random.new.rand(1..10000).to_s)
  end
  
  def contact(params)
    @params = params
    mail(:to => 'jamalsoueidan@me.com', :subject => 'Kontakt os')
  end
end
