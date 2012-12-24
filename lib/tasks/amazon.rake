namespace :amazon do  
  
  task :upload_assets => [:environment, :connect] do 
    connect
    list(File.join(Rails.root, 'public', 'assets'))
  end
  
  def list(path)  
    return unless path.index('/.') == nil
    Dir.foreach(path) do |file|
      fullpath = File.join(path, file)
      if File.directory?(fullpath)
        list(fullpath)
      else
        upload(:key => fullpath[fullpath.index('assets')..-1], :path => fullpath)
      end
    end
  end
  
  task :connect do
    config = YAML.load(File.read("#{Rails.root}/config/s3.yml"))
    AWS.config(config[Rails.env])
    
    s3 = AWS::S3.new
    $bucket = s3.buckets[config[Rails.env]['bucket']]
  end
  
  def upload(options = {})
    p options[:key]
    o = $bucket.objects[options[:key]]
    o.write(:file => options[:path], :acl => :public_read)
  end
  
  task :backup_database => [:environment, :connect] do
    config = YAML.load(File.read("#{Rails.root}/config/database.yml"))
    environment = config[Rails.env]

    filename = Time.now.strftime('%d%m%y-%H%M%S') + '.sql'
    path = File.join(Rails.root, filename)

    command = ["mysqldump -u #{environment['username']}"]
    command << "--password=#{environment['password']}" unless environment['password'].nil?
    command << "#{environment['database']} > " + path
    
    system command.join(' ')

    upload({:key => 'database_backup/' + filename, :path => path})
    system 'rm ' + filename
  end
end