//
//  StickerView.h
//  PicJoin
//
//  Created by steve Nam on 2/22/15.
//  Copyright (c) 2015 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerView : UIView
{
    CGFloat _previousRotation;
    CGFloat _previousScale;
    CGFloat _beginX;
    CGFloat _beginY;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
