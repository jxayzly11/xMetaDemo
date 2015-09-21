//
//  AppDelegate.m
//  XcodeDemo
//
//  Created by Allen Zeng on 15/9/18.
//  Copyright © 2015年 metafun. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MetaConfig.h"

#import <MetaBase/MetaBase.h>

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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    ViewController* viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
    BOOL isRemoveAds = NO;
    
    [MetaBase initMeta:viewController];
    
#if(SDK_METAPLATFORM == SDK_OPEN)
    [MetaPlatform initMeta:viewController];
    isRemoveAds = ([[MetaPlatform readPlatConfig:@"mp_sob" defaultValue:@"false"] compare:@"true"] == NSOrderedSame);
#endif
    
#if(SDK_METAADS == SDK_OPEN)
    [MetaAds initMeta:viewController removeAds:isRemoveAds];
#endif
    
#if(SDK_METAVIDEO == SDK_OPEN)
    [MetaVideo initMeta:viewController removeAds:isRemoveAds];
#endif
    
#if(SDK_METAFACEBOOK == SDK_OPEN)
    [MetaFacebook initMeta:viewController];
#endif
    
#if (SDK_METAREPLAY == SDK_OPEN)
    [MetaReplay initMeta:viewController];
#endif
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
#if(SDK_METAFACEBOOK == SDK_OPEN)
    [MetaFacebook applicationDidBecomeActive:application];
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application {
#if(SDK_METAFACEBOOK == SDK_OPEN)
    [MetaFacebook applicationWillTerminate:application];
#endif
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
#if(SDK_METAFACEBOOK == SDK_OPEN)
    return [MetaFacebook application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
#endif
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
#if(SDK_METAFACEBOOK == SDK_OPEN)
    return [MetaFacebook application:application handleOpenURL:url];
#endif
    return YES;
}


@end
