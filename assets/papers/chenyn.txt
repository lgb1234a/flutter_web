---
title: iOS项目拆分后xib导致的崩溃异常
date: 2018-05-29 11:18:44
categories: iOS
---
> 上个迭代产品提了个需求，说现在的登录注册页面`UI`设计太丑了，需要换一个“清爽”一点的界面。然后，看了看“前人们”留下的若干年前的代码，顶住架构童鞋禁用`xib`的要求（因为会增加包体积大小，公司对这一块还是挺敏感的），毅然决定用`xib`做（毕竟这个需求只估了3天，加上老代码由于之前人交接不善，近乎烂尾，连文档都没了，注释也没有一行，逻辑全靠猜）。
> 
> 不紧不慢，把以前的需求理清楚，`xib`画`UI`确实爽到，不用再浪费时间去`alloc - init`了，可以腾出更多的时间在业务上面。
> 
> 提完代码，review OK，打包，提测，回归，一切都在掌握之中。（这里要交代一下背景，我们项目之前由于业务扩张的原因，整个工程也臃肿不堪，然后举全App研发之力，把工程按照业务模块给拆分成了一个个私有仓库，这次的登录注册也是独立的一个`login`仓库）
> 
> 然后，我们架构小哥“手贱”拉了`login`仓库的代码，噩梦就开始了，每每他点击登录，拉起登录页的时候，就会`crash`。我找到其他组热心的小哥，也拉了一下`login`的代码，并不会复现（由于我上次要调试一台`iOS` 11.3的ipX，`Xcode`更新到了9.3.1，那位热心小哥是`Xcode` 9.2.1，架构小哥后面也更新到9.3.1），说明我提交进仓库的代码并没有问题。
> 下面是异常信息：
```
Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<**LoginViewController 0x************> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key **. '
```
<!-- more -->

> 好了，前面扯了那么多故事背景，终于引出来要讲的东西了。看到这，稍微有些`xib`经验的童鞋应该知道报错原因吧：**不就是xib绑定到VC的属性，关联失败，导致KVC报错嘛**。比较常见的情况就是你修改了`.h`或`.m`里面的属性名，但是没有重新关联，就会报这个异常。看到上面背景交代的一大段废话，差不多就可以排除这个原因了。但肯定还是关联出了问题。后面架构童鞋把`login`仓库放开，进入`debug`模式，然后点登录的时候，完全OK。这就更验证了我的猜想：**应该是哪里的配置导致在cocoapods的代码在以静态库的形式链接到主工程的时候，xib里面的控件关联到File’s Owner失败**
> gg到有人是因为添加一个自定义`view`到`sb`上的`view`中，会导致同样的现象
![stackoverflow][image-1]
> 而帮助他解决问题的是这个不起眼的东西`Inherit Module From Target`：
![stackoverflow][image-2]
> 从字面意义上看，好像并不能看出来什么：**从当前Target继承模块？**
> 指望从官方文档中获取信息，无果。从`Stack Overflow`上得到的解释是：
```
My project has a variety of targets (free, paid, home free, home paid) and I have a class that is only used in the home variants.

When I just added my class and let it default to Module I kept getting an error at run time that the class was not defined in the storyboard.

By checking the "Inherited from Target" option the module gets compiled in for the targets I use it in (Target Memberships for swift file and everything works.

I am assuming this was an optimization so the module would not be included when not needed - but that is just a guess.

Needless to say this wasted an entire day to figure out - hope it helps some others.
```
> 他猜想的是：他的项目中有许多`Target`，勾上这个选项，可以让这个组件在需要时被引入。
> 那么当架构童鞋放开仓库代码`debug`和没有放开的时候，在链接的时候，有什么不同，会导致`xib`指定的`File's Owner`关联到`xib`出错呢？换言之，就是在`debug`的时候`File's Owner`是可以被编译器找到的，因为`debug`的时候，主工程是直接编译链接的仓库源码，但在不开放仓库的时候，添加到主工程的仓库`framework`会导致`xib`关联失败。
> 抱着死马当活马医的心态，我让他勾选了这个选项，再把仓库代码收起来，以静态库的形式添加到主工程，点击登录，问题不复现了。
> 由于只有现象，没有文档佐证，只能提出我的猜想：**在放开仓库源码的时候，工程运行正常，这很好理解。在仓库收起来的时候，静态库链接的过程中，存在xib的File’s Owner找不到的情况（原因未知），而这个选项，可以使编译器在链接的时候，找到明确的File’s Owner指定的那个VC的路径，从而保证可以关联到对应的xib上面的控件**
> 但是这一切只是猜测，官方对于这个开关只字未提，想到上面那位小哥的吐槽：
```
Unfortunately, due to lack of proper documentation, developing for Apple is like this: 10 seconds to add a feature, 10 hours to make it work.
```
> 如果有哪位童鞋有自己的见解，或者更明确的解释，欢迎联系
> mail: chenynle@gmail.com ，wx:  Chenynle

[image-1]:	https://s1.ax1x.com/2018/05/29/C4TjZn.png
[image-2]:	https://s1.ax1x.com/2018/05/29/C4Hn7n.png