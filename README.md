[![Build Status](https://travis-ci.org/dopcn/HotDaily.svg?branch=master)](https://travis-ci.org/dopcn/HotDaily)

**「天涯热帖」**是我 iOS 开发入门边学边练进行的项目，用到的库
```objc
pod 'AFNetworking', '~> 2.5.1'
pod 'SDWebImage', '~> 3.7.1'
pod 'WebViewJavascriptBridge', '~> 4.1.4'
pod 'ReactiveCocoa', '~> 2.4.7'
pod 'FMDB', '~> 2.5'
pod 'MBProgressHUD', '~> 0.9.1'
```
使用到第三方服务 ShareSDK LeanCloud

------

现在回头看那时写的代码，其实有很多应当改进的地方。如果你在寻找一个 iOS 入门的实例，这里包含了基于 AF 的简单网络请求，基于 FMDB 的基本数据库操作，作为 Hybird APP 实现了简单的 objc JavaScript 间数据传递，至于 ReactiveCocoa 在这个项目里可能显示出的威力并不大但是对于一个项目的功能和逻辑复杂度上升函数，使用 reactive 和 functional 的概念可以尽可能使项目开发难度上升函数的一阶导数低于前者，算是一个有益的尝试。MVVM 是有价值的也是不值一提的，入门的时候作用更多是装个逼呵呵。引用了 kiwi 但是并没写测试

iOS 开发从 0 到上架第一个应用其实可以很快，其中的过程其实可以很有趣。如果不要把过多的重点放在上架意味着什么，从 0 到 1 的过程其实是学习 iOS 开发最能体会到自己提高的一段过程，如果你没有在这个过程中体会到乐趣，那就需要警惕自己变成那种需要提醒自己不要因为出发的太久忘记当初为什么出发的人。

总结一些学习心得：

1. storyboard 一定要从开始就想着分 board，一个人开发没有 merge 的问题，但是打开很慢也是大问题
2. 不一定要用固定的逻辑划分模式，我更倾向用固定的物理标量界限例如500行，而不是每个 viewController 都分 viewModel 出去
3. 主线程更新 UI，在 AF 的 block 里进行 [tableView reloadData] 有的时候甚至大部分时候是有效果的，但一定有出问题的时候
4. property 的数量和一个类的不稳定性的相关系数大于 0
5. 服务器是善变的

因为不再打算更新，所以上传了完整包括 pods 的源文件，只要下载源代码，`注释掉或者提供你自己的 ShareSDK key LeanCloud key 等等`就可以运行的起来，上架的版本用的是我的。源代码里包含的 iPad 版本只是为了实现 Quora iPad 版的固定左侧窄边栏并没有真正实现。

应用图片

![image](https://github.com/dopcn/HotDaily/blob/master/images/5_5upload1.jpg)

![image](https://github.com/dopcn/HotDaily/blob/master/images/5_5upload2.jpg)




