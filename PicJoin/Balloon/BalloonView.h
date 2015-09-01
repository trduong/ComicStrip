//
//  BalloonView.h
//  PicJoin
//
//  Created by steve Nam on 12/26/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinBalloonView.h"

@protocol BalloonViewDelegate <NSObject>

- (void)didSelectEditBalloonView:(NSString *)contentText;

@end

@interface BalloonView : UIView
{
    CGPoint _endPoint;
    PinBalloonView *_pinArrow;
    UIMenuController *menuController;
    CGFloat _previousScale;
    BalloonType _balloonType;
    NSMutableArray *_defaultPoints;

}

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, assign) CGRect bubbleRect;
@property (nonatomic, assign) id <BalloonViewDelegate> delegate;

- (void)setBalloonText:(NSString *)text andBalloonType:(BalloonType)balloonType;

@end
