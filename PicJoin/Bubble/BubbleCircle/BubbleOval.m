//
//  BubbleOval.m
//  picapp
//
//  Created by Vumai on 4/3/15.
//  Copyright (c) 2015 Uvney. All rights reserved.


#import "BubbleOval.h"


@implementation BubbleOval

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawFrameBubbleOvalWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;


    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02350) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05963) + 0.5, floor(CGRectGetWidth(frame) * 0.98077) - floor(CGRectGetWidth(frame) * 0.02350), floor(CGRectGetHeight(frame) * 0.95872) - floor(CGRectGetHeight(frame) * 0.05963))];
    [backgroundColor setFill];
    [ovalPath fill];
    [boderColor setStroke];
    ovalPath.lineWidth = boder;
    [ovalPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.13248 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.28440 + 0.5), floor(CGRectGetWidth(frame) * 0.88034 + 0.5) - floor(CGRectGetWidth(frame) * 0.13248 + 0.5), floor(CGRectGetHeight(frame) * 0.74312 + 0.5) - floor(CGRectGetHeight(frame) * 0.28440 + 0.5))];
    [backgroundColor setFill];
    [rectanglePath fill];
}

+ (void)drawArrowBorderWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;

    //// Polygon Drawing
    UIBezierPath* polygonPath = UIBezierPath.bezierPath;
    [polygonPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50926 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08803 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78704 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98944 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21296 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98944 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50926 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08803 * CGRectGetHeight(frame))];
    [polygonPath closePath];
    [backgroundColor setFill];
    [polygonPath fill];
    [boderColor setStroke];
    polygonPath.lineWidth = boder;
    [polygonPath stroke];
}

+ (void)drawArrowWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;

    //// Polygon Drawing
    UIBezierPath* polygonPath = UIBezierPath.bezierPath;
    [polygonPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50926 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08803 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78704 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98944 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21296 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98944 * CGRectGetHeight(frame))];
    [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50926 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08803 * CGRectGetHeight(frame))];
    [polygonPath closePath];
    [backgroundColor setFill];
    [polygonPath fill];
}

@end
