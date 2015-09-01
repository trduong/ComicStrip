//
//  AllBubble.m
//  ProjectName
//
//  Created by Vumai on 4/13/15.
//  Copyright (c) 2015 Uvney. All rights reserved.

#import "AllBubble.h"


@implementation AllBubble

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawSquareBoWithFrame: (CGRect)frame boder: (CGFloat)boder radius: (CGFloat)radius bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02283 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05208 + 0.5), floor(CGRectGetWidth(frame) * 0.97260 + 0.5) - floor(CGRectGetWidth(frame) * 0.02283 + 0.5), floor(CGRectGetHeight(frame) * 0.93750 + 0.5) - floor(CGRectGetHeight(frame) * 0.05208 + 0.5)) cornerRadius: radius];
    [backgroundColor setFill];
    [rectanglePath fill];
    [boderColor setStroke];
    rectanglePath.lineWidth = boder;
    [rectanglePath stroke];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.12329 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.20833 + 0.5), floor(CGRectGetWidth(frame) * 0.87671 + 0.5) - floor(CGRectGetWidth(frame) * 0.12329 + 0.5), floor(CGRectGetHeight(frame) * 0.78125 + 0.5) - floor(CGRectGetHeight(frame) * 0.20833 + 0.5))];
    [backgroundColor setFill];
    [rectangle2Path fill];
}

+ (void)drawSquareWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02273 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05102 + 0.5), floor(CGRectGetWidth(frame) * 0.97273 + 0.5) - floor(CGRectGetWidth(frame) * 0.02273 + 0.5), floor(CGRectGetHeight(frame) * 0.93878 + 0.5) - floor(CGRectGetHeight(frame) * 0.05102 + 0.5))];
    [backgroundColor setFill];
    [rectanglePath fill];
    [boderColor setStroke];
    rectanglePath.lineWidth = boder;
    [rectanglePath stroke];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.10000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.20408 + 0.5), floor(CGRectGetWidth(frame) * 0.90455 + 0.5) - floor(CGRectGetWidth(frame) * 0.10000 + 0.5), floor(CGRectGetHeight(frame) * 0.78571 + 0.5) - floor(CGRectGetHeight(frame) * 0.20408 + 0.5))];
    [backgroundColor setFill];
    [rectangle2Path fill];
}

+ (void)drawStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49633 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04288 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57190 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14346 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49631 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04286 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53241 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09091 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65761 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09433 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65761 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16364 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65761 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65146 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10072 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11634 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.70812 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13900 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11634 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77086 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22419 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11634 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76931 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16625 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86965 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22013 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82242 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22207 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86524 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22031 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83088 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31949 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.87002 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22012 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.85308 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26312 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.90207 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33863 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85902 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48889 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.97029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91122 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42701 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97763 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61537 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.91466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54822 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97763 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61537 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.84549 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65780 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.97763 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61537 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91367 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63591 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87895 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74275 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.86484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70692 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.87895 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74275 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78544 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73891 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.87895 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74275 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.83730 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74104 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.78741 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80429 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.78925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65758 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82254 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.78925 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84459 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67100 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.66540 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88107 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67100 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84367 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.67100 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63752 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88835 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52211 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95146 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55698 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89945 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52211 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95146 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42487 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.83542 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52211 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95146 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47300 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89285 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88401 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35457 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81620 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92305 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34632 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87802 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27979 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84045 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.20337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20660 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75806 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.20337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86524 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.20486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81572 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10353 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76230 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.15039 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76038 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.10353 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76230 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68281 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.10353 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76230 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.11661 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72911 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.03093 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66013 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.07791 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67039 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.03093 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66013 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14776 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50569 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.03093 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66013 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.09653 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57342 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.09276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44048 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14561 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32383 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.02232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35698 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.08059 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34131 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11246 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.12642 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27511 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.11246 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23966 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24291 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.11247 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23966 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.14658 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24106 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18289 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14400 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.18680 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18890 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.18289 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14400 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34472 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18803 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.18289 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14400 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26620 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16667 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32691 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33470 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11299 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.32691 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41717 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14818 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32691 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05465 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.36767 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09689 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49627 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04290 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09474 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49501 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04458 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49633 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04288 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [backgroundColor setFill];
    [bezierPath fill];
    [boderColor setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.23375 + 0.31) + 0.19, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.31664 + 0.43) + 0.07, floor(CGRectGetWidth(frame) * 0.74973 + 0.31) - floor(CGRectGetWidth(frame) * 0.23375 + 0.31), floor(CGRectGetHeight(frame) * 0.68202 + 0.43) - floor(CGRectGetHeight(frame) * 0.31664 + 0.43))];
    [backgroundColor setFill];
    [rectanglePath fill];
}

+ (void)drawArrowBoderBubbleStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93852 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39482 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76928 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39884 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10656 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56814 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32696 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31533 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91109 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93852 * CGRectGetHeight(frame))];
    [bezier2Path closePath];
    [backgroundColor setFill];
    [bezier2Path fill];
    [boderColor setStroke];
    bezier2Path.lineWidth = boder;
    [bezier2Path stroke];
}

+ (void)drawArrowBubbleStarWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93852 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39482 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76928 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39884 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10656 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56814 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32696 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31533 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91109 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93852 * CGRectGetHeight(frame))];
    [bezier2Path closePath];
    [backgroundColor setFill];
    [bezier2Path fill];
}

+ (void)drawOvalDashWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02455) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05238) + 0.5, floor(CGRectGetWidth(frame) * 0.97545) - floor(CGRectGetWidth(frame) * 0.02455), floor(CGRectGetHeight(frame) * 0.94762) - floor(CGRectGetHeight(frame) * 0.05238))];
    [backgroundColor setFill];
    [ovalPath fill];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.84070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17391 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.84070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82609 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.02886 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35400 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.02886 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64600 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82609 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65254 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00619 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34746 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00619 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17391 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.02886 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64600 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.02886 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35400 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18094 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15442 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16636 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16716 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17357 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16066 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.84070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17391 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37017 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00594 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65959 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00056 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [boderColor setStroke];
    bezierPath.lineWidth = boder;
    CGFloat bezierPattern[] = {6, 4};
    [bezierPath setLineDash: bezierPattern count: 2 phase: 0];
    [bezierPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.11607 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.29524 + 0.5), floor(CGRectGetWidth(frame) * 0.89732 + 0.5) - floor(CGRectGetWidth(frame) * 0.11607 + 0.5), floor(CGRectGetHeight(frame) * 0.69524 + 0.5) - floor(CGRectGetHeight(frame) * 0.29524 + 0.5))];
    [backgroundColor setFill];
    [rectanglePath fill];
}

+ (void)drawArrowBoderOvalDashWithFrame:(CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;
    
    //// Star 3 Drawing
    UIBezierPath* star3Path = UIBezierPath.bezierPath;
    [star3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00763 * CGRectGetHeight(frame))];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.82692 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98473 * CGRectGetHeight(frame))];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.17095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98473 * CGRectGetHeight(frame))];
    [star3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00763 * CGRectGetHeight(frame))];
    [star3Path closePath];
    [boderColor setStroke];
    star3Path.lineWidth = boder;
    CGFloat star3Pattern[] = {6, 4};
    [star3Path setLineDash: star3Pattern count: 2 phase: 0];
    [star3Path stroke];
    
    
    //// Star 2 Drawing
    UIBezierPath* star2Path = UIBezierPath.bezierPath;
    [star2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06870 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97814 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19018 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97814 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06870 * CGRectGetHeight(frame))];
    [star2Path closePath];
    [backgroundColor setFill];
    [star2Path fill];
}

+ (void)drawArrowOvalDashWithFrame: (CGRect)frame bgColor:(UIColor*)bgColor;
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    
    //// Star 2 Drawing
    UIBezierPath* star2Path = UIBezierPath.bezierPath;
    [star2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06870 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97814 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.19018 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97814 * CGRectGetHeight(frame))];
    [star2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06870 * CGRectGetHeight(frame))];
    [star2Path closePath];
    [backgroundColor setFill];
    [star2Path fill];
}

+ (void)drawArrowBoderPointerWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor bdColor:(UIColor*)bdColor;
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    UIColor* boderColor = bdColor;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41279 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97541 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41279 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04234 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58721 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00617 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [backgroundColor setFill];
    [bezierPath fill];
    [boderColor setStroke];
    bezierPath.lineWidth = boder;
    [bezierPath stroke];

}

+ (void)drawArrowPointerWithFrame: (CGRect)frame boder: (CGFloat)boder bgColor:(UIColor*)bgColor;
{
    //// Color Declarations
    UIColor* backgroundColor = bgColor;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41279 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97541 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41279 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04234 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58721 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26571 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99079 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00617 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [backgroundColor setFill];
    [bezierPath fill];
}

@end
