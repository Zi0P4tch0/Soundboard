Pod::Spec.new do |s|
  s.name          = "Soundboard"
  s.version       = "1.0"
  s.summary    = "ObjC library to read clips from a soundboard (custom format)."
  s.homepage   = "https://github.com/Zi0P4tch0/Soundboard"
  s.license       = 'GPL'
  s.author      = {'Matteo Pacini' => 'ispeakprogramming@gmail.com'}
  s.source       = { :git => 'https://github.com/Zi0P4tch0/Soundboard.git', :tag => '1.0' }
  s.platform       = :ios
  s.source_files  = 'Soundboard/*.{h,m}'
  s.framework   = 'Foundation'
  s.requires_arc = true
  s.ios.deployment_target = '4.3'
end
