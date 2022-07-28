#
#  Be sure to run `pod spec lint LetvPlayer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "LetvPlayer"
  spec.version      = "1.0.3"
  spec.summary      = "乐视视频播放SDK."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                      乐视视频iOS播放SDK，主要提供通过vid获取p2p播放地址及CDN播放地址，提供p2p功能
                   DESC

  spec.homepage     = "https://github.com/phoenixbull/LetvPlayer"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "letv" => "liuzhibin@letv.com" }
  

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  spec.platform     = :ios, "9.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/phoenixbull/LetvPlayer.git", :tag => "#{spec.version}" }

  # 当前目录是podspec文件所在的目录
  # 等号后表示的是要添加 CocoaPods 依赖的库在项目中的相对路径
  # “**”这个通配符代表  s.source_files  = "TFKit-OC/TFKit-OC/TFKit/*"
  # 次级文件夹
  # spec.subspec 'TF_Category' do |ss|
  # ss.source_files = 'TFKit-OC/TFKit-OC/TFKit/TF_Category/*'
  # end

  # spec.subspec 'TF_BaseClass' do |ss|
  # ss.source_files = 'TFKit-OC/TFKit-OC/TFKit/TF_BaseClass/*'
  # end

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "LetvPlayer/*.{h,m}", "LetvPlayer/**/*.{h,m}","3rd/*.h"
  # spec.exclude_files = "Classes/Exclude"

  spec.public_header_files = "LetvPlayer/LetvPlayer.h","LetvPlayer/LetvPlayerManager.h","LetvPlayer/LetvPlayerSdkController.h"
  spec.pod_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]": "arm64",
    'VALID_ARCHS[sdk=iphonesimulator*]' => ''
  }
  spec.user_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]": "arm64"
  }
  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  spec.framework  = "Foundation"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  spec.library   = "c++"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.requires_arc = true

  # 库中用到的框架或系统库（没用到可以没有）
  # spec.ios.frameworks = 'Foundation', 'UIKit'
  # spec.framework  = ""
  # spec.frameworks = "", ""
  # spec.libraries = "",""
  # 使用到的第三方库
   # spec.vendored_frameworks = ''
  spec.vendored_libraries = '3rd/*.a'

  spec.xcconfig = { "USER_HEADER_SEARCH_PATHS" => "3rd/*.h" }
  spec.dependency "ReactiveObjC", "~> 3.1.0"
  spec.dependency "AFNetworking", "~> 4.0"
  spec.dependency "JSONModel"

end
