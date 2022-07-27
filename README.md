乐视视频播放SDK
=============
安装方式
------------
pod 'LetvPlayer' =>'1.0.0'

项目配置
------------
1、打开项目中的info.plist文件,在其中添加一个字典类型的项目App Transport Security Settings,然后在其中添加一个key:Allow Arbitrary Loads,其值为YES.如下所示：

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
2、配置依赖系统类库
分别点击：
__Target-> Build Phases -> Link Binary With Libraries__ 
增加
__libc++.tbd__ 
类库即可

SDK使用
-------
1、 SDK初始化
```
#import <LetvPlayer/LetvPlayer.h>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    LetvPlayerManager_Initialize(@"test Demo");// 产品线标示
    return YES;
}
```

2、具体调用
继承LetvPlayerSdkControllerProtocol 协议
声明 LetvPlayerSdkController *player 对象

```
@interface xxxxxxxxxxx ()<LetvPlayerSdkControllerProtocol>
@property (nonatomic, strong) LetvPlayerSdkController *player;
@end


self.player = [[LetvPlayerSdkController alloc] initWithVid:@"66901427" p2p:YES streamCode:LetvMobilePlayerStreamCodeSD];
self.player.delegate = self;
[self.player startProcess];

- (void)LetvMobilePlayerControllerSuccess:(NSString *)url useP2p:(BOOL)p2p metadata:(NSDictionary *)metaDict
{
    NSLog(@"request success p2p status: %d  url is %@",p2p,url);
    self.playerView  = [[VideoPlayerView alloc] initWithFrame:CGRectMake(0, 44+20, self.view.frame.size.width, 350) andPath:url];
    [self.view addSubview:self.playerView];
}

- (void)LetvMobilePlayerControllerFailed:(NSError *)error useP2p:(BOOL)p2p
{
    NSLog(@"request failed p2p status: %d  err is %@",p2p,error);

}
```

3、具体参数说明

[[LetvPlayerSdkController alloc] initWithVid:@"66901427" p2p:YES streamCode:LetvMobilePlayerStreamCodeSD];



| 参数 | 类型 | 描述  | 备注 |
| ------------- | ------------- | ------------- | ------------- |
| vid | NSString  | 对应乐视视频的vid  | 服务接口提供  |
| p2p  | BOOL  | 是否返回p2p流地址  | YES: 返回支持p2p播放的流地址  NO： 返回CDN播放流地址  |
| streamCode  | LetvMobilePlayerStreamCode  | 清晰度  | LetvMobilePlayerStreamCodeLD ： 渣清  LetvMobilePlayerStreamCodeMD ： 流畅 LetvMobilePlayerStreamCodeSD ： 标清  LetvMobilePlayerStreamCodeHD ： 高清 LetvMobilePlayerStreamCodeTD ： 超清   |

- (void)LetvMobilePlayerControllerSuccess:(NSString *)url useP2p:(BOOL)p2p metadata:(NSDictionary *)metaDict

| 参数 | 类型 | 描述  | 备注 |
| ------------- | ------------- | ------------- | ------------- |
| url | NSString  | 播放流地址  | 无  |
| p2p  | BOOL  | 是否返回p2p流地址  | YES: 返回支持p2p播放的流地址  NO： 返回CDN播放流地址  |
| metaDict  | NSDictionary | 数据源  | 可忽略，排查问题用  |

LetvMobilePlayerControllerFailed:(NSError *)error useP2p:(BOOL)p2p

| 参数 | 类型 | 描述  | 备注 |
| ------------- | ------------- | ------------- | ------------- |
| error | NSError  | 错误信息  | 无  |
| p2p  | BOOL  | 是否返回p2p流地址  | YES: 返回支持p2p播放的流地址  NO： 返回CDN播放流地址  |



