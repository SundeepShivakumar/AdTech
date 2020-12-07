Pod::Spec.new do |s|

  s.platform         = :ios
  s.name             = 'AdTech'
  s.version          = '0.0.1'
  s.summary          = 'AdTech Framework is built to serve Ad for the respective context.'
  s.requires_arc     = true
 
  s.description      = <<-DESC
                        This framework helps you to power up the Ad in your App with particular context seamlessly.
                       DESC
 
  s.homepage         = 'http://gerrit.mmt.com/admin/repos/APP-iOS-AdTech'
  s.license          = { :type => 'Make My Trip Group', :file => 'LICENSE' }
  s.author           = { 'Sundeep Shivakumar' => 'sundeep@go-mmtcom' }
  s.source           = { :git => 'ssh://gerrit.mmt.com:29418/APP-iOS-AdTech', :tag => s.version.to_s }
 
  s.framework        = "UIKit"

  s.ios.deployment_target = '10.0'

  s.source_files = 'AdTech/**/*.{swift}'
  s.resources = "AdTech/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.swift_version = "4.2"
 
end
