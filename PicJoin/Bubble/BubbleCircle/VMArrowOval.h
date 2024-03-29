//
//  VMArrowOval.h
//  testbubbletext
//
//  Created by Vu Mai on 4/3/15.
//  Copyright (c) 2015 VuMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleOval.h"
#import "BubbleCloud.h"
#import "AllBubble.h"
@interface VMArrowOval : UIView

@property (nonatomic) CGFloat border;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) NSInteger type;

-(void)generateArrowCloudWithFrame:(CGRect)frameView withBgColor:(UIColor*)cl;
@end
