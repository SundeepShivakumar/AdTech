Pod::Spec.new do |s|
  s.name             = 'AdTech'
  s.version          = '0.0.1'
  s.summary          = 'AdTech Framework is built to serve Ad for the respective context.'
 
  s.description      = <<-DESC
                        This framework helps you to power up the Ad in your App with particular context seamlessly.
                       DESC
 
  s.homepage         = 'http://gerrit.mmt.com/admin/repos/APP-iOS-AdTech'
  s.license          = { :type => 'Make My Trip Group', :file => 'LICENSE' }
  s.author           = { 'Sundeep Shivakumar' => 'sundeep@go-mmtcom' }
  s.source           = { :git => 'ssh://gerrit.mmt.com:29418/APP-iOS-AdTech', :tag => s.version.to_s }
 
  s.ios.deployment_target = '12.0'
  s.source_files = 'AdTech/*'
 
end