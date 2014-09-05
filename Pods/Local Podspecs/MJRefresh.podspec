Pod::Spec.new do |s|
  s.name     = 'MJRefresh'
  s.version  = '1.0.0'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Give pull-to-refresh to any UIScrollView with 1 line of code.'
  s.homepage = 'https://github.com/CoderMJLee/MJRefresh'
  s.author   = { 'CoderMJLee' => 'https://github.com/CoderMJLee' }
  s.source   = { :git => '~/Documents/MJRefresh'}

  s.description = 'MJRefresh allows you to easily add pull-to-refresh ' \
                  'functionality to any UIScrollView subclass with only 1 ' \
                  'line of code. Instead of depending on delegates and/or ' \
                  'subclassing UIViewController, SVPullToRefresh extends ' \
                  'UIScrollView with a addPullToRefreshWithActionHandler: ' \
                  'method as well as a pullToRefreshView property.'

  s.requires_arc = true
  s.source_files = '**/*.{h,m}'
  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MJRefresh"' }
  s.resources = "MJRefresh/MJRefresh.bundle/**/*.png"
  s.frameworks = 'UIKit'
end
