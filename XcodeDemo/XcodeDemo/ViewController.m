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
    // Do any additional setup after loading the view, typically from a nib.
    
    //add logo
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100,100,200,200)];
    imageView.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:imageView];
    
    //load game Resource below here
    
    //After 3 second,set load callback
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MetaAds setLoadCallBack:^(){
            [MetaAds showBanner];
            [imageView removeFromSuperview];
            
            //game begin
            
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
