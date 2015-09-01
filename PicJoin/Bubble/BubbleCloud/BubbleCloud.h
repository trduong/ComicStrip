//
//  BubbleCloud.h
//  Picapp
//
//  Created by Vumai on 4/13/15.
//  Copyright (c) 2015 Uvney. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BubbleCloud : NSObject

// Drawing Methods
+ (void)drawCloudWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawCircleArrowWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawCircleWithFrame: (CGRect)frame bgColor:(UIColor*)bgColor;

@end
