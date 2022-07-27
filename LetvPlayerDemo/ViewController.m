//
//  ViewController.m
//  LetvPlayerDemo
//
//  Created by letv_lzb on 2022/7/15.
//

#import "ViewController.h"
#import <LetvPlayer/LetvPlayerManager.h>
#import <LetvPlayer/LetvPlayerSdkController.h>
#import "VideoPlayerView.h"

@interface ViewController ()<LetvPlayerSdkControllerProtocol>
@property (nonatomic, strong) LetvPlayerSdkController *player;
@property(nonatomic, strong) VideoPlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[LetvPlayerSdkController alloc] initWithVid:@"66901427" p2p:YES streamCode:LetvMobilePlayerStreamCodeSD];
    self.player.delegate = self;
}


- (IBAction)testAction:(id)sender {
    [self.player startProcess];
}


- (void)LetvMobilePlayerControllerSuccess:(NSString *)url useP2p:(BOOL)p2p metadata:(NSDictionary *)metaDict
{
    NSLog(@"request success p2p status: %d  url is %@",p2p,url);
    self.playerView  = [[VideoPlayerView alloc] initWithFrame:CGRectMake(0, 44+20, self.view.frame.size.width, 350) andPath:url];
    [self.view addSubview:self.playerView];
    self.testBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, CGRectGetMaxY(self.playerView.frame), 100, 50);
    [self.view bringSubviewToFront:self.testBtn];

}

- (void)LetvMobilePlayerControllerFailed:(NSError *)error useP2p:(BOOL)p2p
{
    NSLog(@"request failed p2p status: %d  err is %@",p2p,error);

}



- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"size = w = %f h = %f -----",size.width,size.height);

    [self.playerView resetFrame:size];
}

@end
