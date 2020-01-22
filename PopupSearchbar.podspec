Pod::Spec.new do |s|
  s.name             = 'PopupSearchbar'
  s.version          = '0.1.0'
  s.summary          = 'To display search bar view and popup result view'
 
  s.description      = <<-DESC
This fantastic view changes its color gradually makes your app look fantastic!
                       DESC
 
  s.homepage         = 'https://github.com/intersignature/PopupSearchbar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<YOUR NAME HERE>' => '<YOUR EMAIL HERE>' }
  s.source           = { :git => 'https://github.com/intersignature/PopupSearchbar.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'PopupSearchbar/Searchbar/*.swift'
 
end