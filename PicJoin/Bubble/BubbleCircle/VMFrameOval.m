//
//  VMFrameOval.m
//  testbubbletext
//
//  Created by Vu Mai on 4/3/15.
//  Copyright (c) 2015 VuMai. All rights reserved.
//

#import "VMFrameOval.h"

@implementation VMFrameOval

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    switch (self.type) {
        case 1:
            [BubbleOval drawFrameBubbleOvalWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 2:
            [BubbleCloud drawCloudWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 3:
            [AllBubble drawSquareBoWithFrame:self.bounds boder:3 radius:10 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 4:
            [AllBubble drawSquareWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 5:
            [AllBubble drawStarWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 6:
            [AllBubble drawOvalDashWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 7:
            [AllBubble drawSquareWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        case 8:
            [AllBubble drawSquareWithFrame:self.bounds boder:3 bgColor:self.backgroundColor bdColor:self.boderColor];
            break;
        default:
            break;
    }
    
    
}

@end
