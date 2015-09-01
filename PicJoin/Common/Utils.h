//
//  Utils.h
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)animationShowView:(UIView *)view;

+ (void)animationHidenView:(UIView *)view;

+ (UIView *)viewFromNibNamed:(NSString *)nibName;

+ (BOOL)isIphone4Inch;

+ (BOOL)isIphone35Inch;

+ (BOOL)isIpad;

@end
