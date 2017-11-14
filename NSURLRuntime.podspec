
Pod::Spec.new do |s| 

s.name             = 'NSURLRuntime' 

s.version          = '1.0'
 
s.summary          = 'NSURLRuntime' 

s.description      = <<-DESC 
  It is a component for ios NSURL,written by Objective-C.
                        DESC
s.homepage         = 'https://github.com/ylrs/NSURLRuntime.git'

s.license          = 'MIT' 

s.author           = { 'ylrs' => '278051822@qq.com' }

s.source           = { :git => 'https://github.com/ylrs/NSURLRuntime.git'}

s.platform         = :ios,'7.0'

s.requires_arc     = true 

s.source_files     = 'NSURLRuntime/NSURLRuntime/*.{h,m}' 

end
