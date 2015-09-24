//
//  ViewController.m
//  XcodeDemo
//
//  Created by Allen Zeng on 15/9/18.
//  Copyright © 2015年 metafun. All rights reserved.
//

#import "ViewController.h"
#import "MetaConfig.h"

#if(SDK_METAADS == SDK_OPEN)
#import <MetaAds/MetaAds.h>
#endif
#if(SDK_METAPLATFORM == SDK_OPEN)
#import <MetaPlatform/MetaPlatform.h>
#endif
#if(SDK_METAVIDEO == SDK_OPEN)
#import <MetaVideo/MetaVideo.h>
#endif
#if(SDK_METAFACEBOOK == SDK_OPEN)
#import <MetaFacebook/MetaFacebook.h>
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#if(SDK_METAADS == SDK_OPEN)
    [MetaAds viewWillAppear];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
#if(SDK_METAADS == SDK_OPEN)
    [MetaAds viewWillDisappear];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一步，加载Metafun的Logo，渐显1.2秒（这里忽略）
    self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100,130,200,200)];
    self.logo.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:self.logo];
    
    //第二步，若游戏需要与加载游戏资源，请在现实logo后加载
    
    //第三步，当游戏资源加载完毕后，设置回调。这里我假设游戏加载需要3秒,3秒后我调用 gameLoadOver 来设置回调
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [self gameLoadOver];
    });
}

- (void) gameLoadOver{
    [MetaAds setLoadCallBack:^(){
        //第四步，在回调内部渐隐logo1.2秒之后删除logo（这里忽略），然后进去你游戏的界面
        [self.logo removeFromSuperview];
        [self enterGame];
    }];
}

- (void) enterGame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 100.0f, 60.0f);
    button.center = CGPointMake(160.0f, 140.0f);
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:@"显示插屏" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click_ShowGameAd:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) click_ShowGameAd:(id)sender{
    [MetaAds showGameAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
