//
//  AppDelegate.h
//  PicJoin
//
//  Created by steve Nam on 9/12/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIStoryboard *storyboard;
@property (nonatomic, retain) NSMutableArray *balloonArray;
@property (nonatomic, retain) NSMutableArray *stickerArray;

+ (AppDelegate *)sharedInstance;

@end
