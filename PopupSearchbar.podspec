Pod::Spec.new do |s|
  s.name             = 'PopupSearchbar'
  s.version          = '0.1.1'
  s.summary          = 'update swift 5'
 
  s.description      = <<-DESC
Make popup search bar !!!!
                       DESC
 
  s.homepage         = 'https://github.com/intersignature/PopupSearchbar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sirichai Binchai' => 'intersignature@hotmail.com' }
  s.source           = { :git => 'https://github.com/intersignature/PopupSearchbar.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '13.1'
  s.source_files = 'PopupSearchbar/Searchbar/*.swift'
  s.swift_version = '5.0'
 
end