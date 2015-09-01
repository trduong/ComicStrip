//
//  pinImageView.h
//  decoicon
//
//  Created by とこ とこ on 12/03/18.
//  Copyright (c) 2012年 tokotoko software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PinTypeArrow = 0,
    PinTypeBubble
}PinType;
    
@interface PinBalloonView : UIImageView
{
    CGPoint _oldCenter;
    CGPoint _oldPinPoint;
    CGAffineTransform _oldTransform;
    CGFloat _oldArmLong;
    CGFloat _zoom;
    CGFloat _rotation;
}

@property (nonatomic,retain) UIView *controllingView;
@property (nonatomic,assign) PinType pinType;
@property (nonatomic, assign) BOOL removing;

- (id)initWithView:(UIView *)targetView;
- (void)setStartPoint:(CGPoint )point;
- (void)translateToPoint:(CGPoint)point;

@end
