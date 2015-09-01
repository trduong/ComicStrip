//
//  AllBubble.h
//  ProjectName
//
//  Created by Vumai on 4/13/15.
//  Copyright (c) 2015 Uvney. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AllBubble : NSObject

// Drawing Methods
+ (void)drawSquareBoWithFrame: (CGRect)frame boder: (CGFloat)boder radius: (CGFloat)radius bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;

+ (void)drawSquareWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowBoderBubbleStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowBubbleStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor;

+ (void)drawOvalDashWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowBoderOvalDashWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;

+ (void)drawArrowOvalDashWithFrame: (CGRect)frame bgColor:(UIColor*)bgColor;
+ (void)drawArrowBoderPointerWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
+ (void)drawArrowPointerWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor;

@end
