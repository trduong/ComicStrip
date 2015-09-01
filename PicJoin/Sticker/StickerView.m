//
//  StickerView.m
//  PicJoin
//
//  Created by steve Nam on 2/22/15.
//  Copyright (c) 2015 Atmarkcafe. All rights reserved.
//

#import "StickerView.h"

@implementation StickerView

- (void)awakeFromNib
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [self addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:panGesture];

}

- (void)rotateImage:(UIRotationGestureRecognizer *)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        _previousRotation = 0.0;
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGFloat newRotation = 0.0 - (_previousRotation - [recognizer rotation]);
    
    CGAffineTransform currentTransformation = _backgroundImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransformation, newRotation);
    _backgroundImageView.transform = newTransform;
    _previousRotation = [recognizer rotation];
    [UIView commitAnimations];
}

- (void)scaleImage:(UIPinchGestureRecognizer *)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        _previousScale = [recognizer scale];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[self.layer valueForKeyPath:@"transform.scale"] floatValue];
        const CGFloat kMinScale = (150/2)/self.frame.size.width;
        CGFloat newScale = 1 -  (_previousScale - [recognizer scale]);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale(self.transform, newScale, newScale);
        self.transform = transform;
        _previousScale = [recognizer scale];
    }
}

- (void)moveImage:(UIPanGestureRecognizer *)recognizer
{
    CGPoint newCenter = [recognizer translationInView:self];
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        
        _beginX = self.center.x;
        _beginY = self.center.y;
    }
    
    newCenter = CGPointMake(_beginX + newCenter.x, _beginY + newCenter.y);
    [self setCenter:newCenter];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
