namespace :js do  
  task :upload => :environment do
    config = YAML.load(File.read("#{Rails.root}/config/s3.yml"))
    AWS.config(config[Rails.env])
    
    s3 = AWS::S3.new
    $bucket = s3.buckets[config[Rails.env]['bucket']]

    list(File.join(Rails.root, 'public', 'assets'))
  end
  
  def upload(options = {})
    p options[:key]
    o = $bucket.objects[options[:key]]
    o.write(:file => options[:path], :acl => :public_read)
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
end



