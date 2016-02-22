Pod::Spec.new do |s|
  s.name         = "SJIniteScrollView"
  s.version      = "0.1"
  s.ios.deployment_target = '6.0'
  s.summary      = "无限图片轮播器,支持本地及网络加载"
  s.homepage     = "https://github.com/king129/SJIniteScrollView"
  s.license      = "MIT"
  s.author             = { "king" => "king129@vip.163.com" }
  s.social_media_url   = "http://weibo.com/CoderKing"
  s.source       = { :git => "https://github.com/king129/SJIniteScrollView.git", :tag => s.version }
  s.source_files  = "SJIniteScrollView"
  s.requires_arc = true
end
