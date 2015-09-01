//
//  pinImageView.m
//  decoicon
//
//  Created by とこ とこ on 12/03/18.
//  Copyright (c) 2012年 tokotoko software. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PinBalloonView.h"
#import "BalloonView.h"

@implementation PinBalloonView

#define SQUARE_SIZE 30

+ (CGFloat)rotationFromCenter:(CGPoint)center point1:(CGPoint)point1 point2:(CGPoint)point2
{
    CGPoint vector1 = CGPointMake(point1.x-center.x, point1.y-center.y);
    CGPoint vector2 = CGPointMake(point2.x-center.x, point2.y-center.y);
    if((vector1.x==0 && vector1.y==0) || (vector2.x==0 && vector2.y==0))return 0;
    //NSLog(@"v1 %@ v2 %@",NSStringFromCGPoint(vector1),NSStringFromCGPoint(vector2));
    CGFloat naiseki = vector1.x*vector2.x + vector1.y*vector2.y;
    CGFloat gaiseki = vector1.x*vector2.y - vector1.y*vector2.x;
    CGFloat seki = sqrtf(vector1.x*vector1.x + vector1.y*vector1.y) * sqrtf(vector2.x*vector2.x + vector2.y*vector2.y);
    CGFloat rotate = acosf(naiseki/seki);
    if (gaiseki>0)rotate*=-1;
    if(isnan(rotate))return 0.0;
    return rotate;
}

- (void)choicePointFromFour:(UIView *)view inView:(UIView *)parentView leftTop:(CGPoint)leftTop rightBottom:(CGPoint)rightBottom
{
    CGPoint choicedPoint;
    CGFloat quarter = abs(leftTop.x - rightBottom.x)/4;
    if (parentView.center.x<parentView.superview.frame.size.width/2) {
        choicedPoint.x = rightBottom.x - quarter;
    } else {
        choicedPoint.x = leftTop.x + quarter;
    }
    
    quarter = abs(leftTop.y - rightBottom.y)/4;
    if (parentView.center.y<parentView.superview.frame.size.height/2) {
        choicedPoint.y = rightBottom.y - quarter;
    } else {
        choicedPoint.y = leftTop.y + quarter;
    }
    
    if(choicedPoint.x<0 || choicedPoint.y<0) {
        choicedPoint.x=30;
        choicedPoint.y=30;
    } else if(choicedPoint.x>parentView.superview.frame.size.width || choicedPoint.x>parentView.superview.frame.size.width) {
        choicedPoint.x=parentView.superview.frame.size.width-30;
        choicedPoint.y=parentView.superview.frame.size.height-30;
    }
    
    [view setFrame:CGRectMake(choicedPoint.x, choicedPoint.y, view.frame.size.width, view.frame.size.height)];
}

- (id)initWithView:(UIView *)targetView
{
    self = [super initWithFrame:CGRectMake(0, 0, SQUARE_SIZE, SQUARE_SIZE)];
    if(self) {
        _controllingView = targetView ;
        [self setUserInteractionEnabled:YES];
        _oldCenter = CGPointMake(targetView.frame.origin.x + (targetView.frame.size.width)/2, targetView.frame.origin.y + (targetView.frame.size.height)/2);
        
        [self setImage:[UIImage imageNamed:@"pin"]];
        
        CGPoint leftTopPoint    =   CGPointMake(targetView.frame.origin.x - SQUARE_SIZE, targetView.frame.origin.y - SQUARE_SIZE);
        CGPoint rightBottomPoint =  CGPointMake(targetView.frame.origin.x + targetView.frame.size.width,
                                                targetView.frame.origin.y + targetView.frame.size.height);
        [self choicePointFromFour:self inView:targetView leftTop:leftTopPoint rightBottom:rightBottomPoint];
        [self addCancelListener];
    }
    return self;
}

- (void)addCancelListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCancelCall) name:@"EditArticlePushedParent" object:nil];
}

- (void)didReceiveCancelCall
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @synchronized(self)
    {
        if(!_removing) {
            [self removeFromSuperview];
            _removing = YES;
        }
    }
}

- (void)setStartPoint:(CGPoint )point
{
    _oldTransform = _controllingView.transform;
    _oldPinPoint = point;
    _oldArmLong = [self armLongWithPoint1:_oldCenter andPoint2:_oldPinPoint];
}

- (CGFloat)armLongWithPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2
{
    return sqrtf((point2.x-point1.x)*(point2.x-point1.x) + (point2.y-point1.y)*(point2.y-point1.y));
}

- (void)translateToPoint:(CGPoint)point
{
    _zoom = [self armLongWithPoint1:_oldCenter andPoint2:point]/_oldArmLong;
    _rotation = [PinBalloonView rotationFromCenter:_oldCenter point1:point point2:_oldPinPoint];
    if (_pinType == PinTypeBubble) {
        BalloonView *view = (BalloonView *) _controllingView;
        view.bubbleRect = CGRectInset(view.bubbleRect, point.x, point.y);
        [view setNeedsDisplay];
    }
}


@end
