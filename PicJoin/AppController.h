//
//  AppController.h
//  PicJoin
//
//  Created by steve Nam on 12/22/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameManager.h"
#import "FrameObject.h"

@interface AppController : NSObject

+ (AppController *)sharedInstance;

- (FrameManager *)getFramesDataFromFile:(NSString *)fileName;

- (void)hidePinBalloonNotification;


@end
