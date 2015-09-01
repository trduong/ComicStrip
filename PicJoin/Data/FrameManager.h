//
//  FrameManager.h
//  PicJoin
//
//  Created by steve Nam on 12/22/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameObject.h"

@interface FrameManager : NSObject
{
    NSMutableArray *_frameList;
}

- (BOOL)add:(FrameObject *)object;
- (FrameObject *)frameObjectAtIndex:(NSInteger)index;
- (void)clear;
- (NSInteger)count;
- (NSMutableArray *)getAllObject;

@end
