//
//  FrameManager.m
//  PicJoin
//
//  Created by steve Nam on 12/22/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "FrameManager.h"

@implementation FrameManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        _frameList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BOOL)add:(FrameObject *)object
{
    @synchronized (_frameList) {
        [_frameList addObject:object];
    }
    
    return YES;
}

- (FrameObject *)frameObjectAtIndex:(NSInteger)index
{
    @synchronized (_frameList) {
        return [_frameList objectAtIndex:index];
    }
}

- (void)clear
{
    @synchronized (_frameList) {
        [_frameList removeAllObjects];
    }
}

- (NSInteger)count
{
    @synchronized (_frameList) {
        return [_frameList count];
    }
}

- (NSMutableArray *)getAllObject
{
    @synchronized (_frameList) {
        return _frameList;
    }
}

@end
