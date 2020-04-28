
Pod::Spec.new do |s|
  s.name         = "RNLiqpay"
  s.version      = "1.0.0"
  s.summary      = "RNLiqpay"
  s.description  = <<-DESC
                  RNLiqpay
                   DESC
  s.homepage     = "http://facebook.github.io/react-native/"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNReactNativeLiqpay.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  