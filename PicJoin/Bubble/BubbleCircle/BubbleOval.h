//
//  BubbleOval.h
//  picapp
//
//  Created by Vumai on 4/3/15.
//  Copyright (c) 2015 Uvney. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BubbleOval : NSObject

// Drawing Methods
+ (void)drawFrameBubbleOvalWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowBorderWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor;

@end
