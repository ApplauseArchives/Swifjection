Pod::Spec.new do |s|
  s.name             = 'Swifjection'
  s.version          = '0.4.1'
  s.summary          = 'Dependency Injection library for Swift'
  s.description      = <<-DESC
Lightweight and simplistic dependency injection framework written in Swift for Swift .
                       DESC
  s.homepage         = 'https://github.com/ApplauseAQI/Swifjection'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Łukasz Przytuła' => 'lprzytula@applause.com',
                         'Aleksander Zubala' => 'azubala@applause.com' }
  s.source           = { :git => 'https://github.com/ApplauseAQI/Swifjection.git', :tag => s.version.to_s }
  s.platforms = { :ios => "8.0", :osx => "10.9", :watchos => "1.0", :tvos => "9.0" }
  s.source_files = 'Swifjection/Classes/**/*'
  s.exclude_files = [
    'Swifjection/Classes/**/*Spec.swift',
    'Swifjection/Classes/**/*Tests.swift'
  ]
end
