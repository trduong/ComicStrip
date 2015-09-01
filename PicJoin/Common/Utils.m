//
//  Utils.m
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)animationShowView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionPush;
    view.hidden = NO;
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (void)animationHidenView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionPush;
    view.hidden = YES;
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (UIView *)viewFromNibNamed:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    UIView *xibBasedView = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[UIView class]]) {
            xibBasedView = (UIView *)nibItem;
            break;
        }
    }
    return xibBasedView;
}

+ (BOOL)isIphone4Inch
{
    if ([[UIScreen mainScreen] bounds].size.width == 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIphone35Inch
{
    if ([[UIScreen mainScreen] bounds].size.width == 480) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIpad
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        return YES;
    }
    
    return NO;
}

@end
