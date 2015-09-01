//
//  AppDelegate.m
//  PicJoin
//
//  Created by steve Nam on 9/12/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "AppDelegate.h"
#import "ComicFrameViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:@"iconBubbleCircle", @"iconBubbleCloud",@"iconBubbleOval",@"iconBubbleSquares",@"iconBubbleStars", @"iconOvalDash", @"iconPointer", @"iconSquare", nil];
    _balloonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [data count]; i++) {
        UIImage *stickerItem = [UIImage imageNamed:[data objectAtIndex:i]];
        [_balloonArray addObject:stickerItem];
    }
    
    NSMutableArray *stiker = [[NSMutableArray alloc] init];
    for (int i = 1; i < 190; i++) {
        [stiker addObject:[NSString stringWithFormat:@"Sticker%d",i]];
    }
    _stickerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [stiker count]; i++) {
        UIImage *balloonItem = [UIImage imageNamed:[stiker objectAtIndex:i]];
        [_stickerArray addObject:balloonItem];
    }
    
    NSString *storyboardName = @"Main_iPhone";
    
    if ([Utils isIphone35Inch]) {
        storyboardName = @"Main_iPhone_3.5";
    } else if ([Utils isIpad]){
        storyboardName = @"Main_iPad";
    }
    
    _storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    self.window.rootViewController = _storyboard.instantiateInitialViewController;
    
    return YES;
}
    
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:@"comicstripapp"]) {
        
        NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
        
        NSString *token = d[@"oauth_token"];
        NSString *verifier = d[@"oauth_verifier"];
        
        ComicFrameViewController *rootViewController = (ComicFrameViewController *)_window.rootViewController;
        
        [rootViewController setOAuthToken:token oauthVerifier:verifier];
    } else if ([[url scheme] isEqualToString:[NSString stringWithFormat:@"fb%@", FACEBOOK_ID]]) {
        return [FBSession.activeSession handleOpenURL:url];
    }
    
    return YES;
}

+ (AppDelegate *)sharedInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}

@end
