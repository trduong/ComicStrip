//
//  AppController.m
//  PicJoin
//
//  Created by steve Nam on 12/22/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "AppController.h"

static AppController *sharedInstance = nil;

@implementation AppController

#pragma mark - Init

+ (AppController *)sharedInstance
{
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppController alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Load Frame

- (FrameManager *)getFramesDataFromFile:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableArray *frameArray = [NSMutableArray arrayWithContentsOfFile:path];
    FrameManager *frameManager = [[FrameManager alloc] init];
    for (NSDictionary *frameDict in frameArray) {
        FrameObject *frameObject = [[FrameObject alloc] init];
        frameObject.thumbImage = [frameDict valueForKey:@"thumbimage"];
        frameObject.regions = [frameDict valueForKey:@"regions"];
        frameObject.index = [[frameDict valueForKey:@"index"] integerValue];
        [frameManager add:frameObject];
    }
    
    return frameManager;
}

- (void)hidePinBalloonNotification
{
    NSNotification *notification= [NSNotification notificationWithName:@"EditArticlePushedParent" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
