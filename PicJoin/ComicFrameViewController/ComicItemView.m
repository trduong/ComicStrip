//
//  ComicItemView.m
//  PicJoin
//
//  Created by steve Nam on 12/16/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "ComicItemView.h"

@implementation ComicItemView
{
    UIImageView *_addImageView;
    UIImageView *_comicImageView;
    CGFloat _previousRotation;
    CGFloat _previousScale;
    CGFloat _beginX;
    CGFloat _beginY;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:230.0/255.0];
        
//        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 44)/2, (frame.size.height - 34)/2, 44, 34)];
//        _addImageView.image = [UIImage imageNamed:@"buttons_plus"];
//        [self addSubview:_addImageView];
        
        UIView *comicView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6)];
        comicView.backgroundColor = [UIColor clearColor];
        comicView.clipsToBounds = YES;
        [self addSubview:comicView];
        
        _comicImageView = [[UIImageView alloc] initWithFrame:comicView.frame];
        _comicImageView.backgroundColor = [UIColor clearColor];
        _comicImageView.contentMode = UIViewContentModeScaleAspectFill;
        [comicView addSubview:_comicImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
        [self addGestureRecognizer:rotationGesture];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
        [self addGestureRecognizer:pinchGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
        [panGesture setMinimumNumberOfTouches:1];
        [panGesture setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:panGesture];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
    CGRect rectangle = rect;
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedChangeImage:)]) {
        [_delegate didSelectedChangeImage:self];
    }
}

- (void)rotateImage:(UIRotationGestureRecognizer *)gesture
{
    if([gesture state] == UIGestureRecognizerStateEnded) {
        _previousRotation = 0.0;
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    
    CGFloat newRotation = 0.0 - (_previousRotation - [gesture rotation]);
    
    CGAffineTransform currentTransformation = _comicImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransformation, newRotation);
    _comicImageView.transform = newTransform;
    _previousRotation = [gesture rotation];
    [UIView commitAnimations];

}

- (void)scaleImage:(UIPinchGestureRecognizer *)gesture
{
    if([gesture state] == UIGestureRecognizerStateBegan) {
        _previousScale = [gesture scale];
    }
    
    if ([gesture state] == UIGestureRecognizerStateBegan ||
        [gesture state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[_comicImageView.layer valueForKeyPath:@"transform.scale"] floatValue];
        const CGFloat kMinScale = (150/2)/_comicImageView.frame.size.width;
        CGFloat newScale = 1 -  (_previousScale - [gesture scale]);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale(_comicImageView.transform, newScale, newScale);
        _comicImageView.transform = transform;
        _previousScale = [gesture scale];
    }
}

- (void)moveImage:(UIPanGestureRecognizer *)gesture
{
    CGPoint newCenter = [gesture translationInView:self];
//    CGRect boundsRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if([gesture state] == UIGestureRecognizerStateBegan) {
        _beginX = _comicImageView.center.x;
        _beginY = _comicImageView.center.y;
    }
    
    newCenter = CGPointMake(_beginX + newCenter.x, _beginY + newCenter.y);
    
//    BOOL isContainsPoint = CGRectContainsPoint(boundsRect,newCenter);
    
//    if (isContainsPoint) {
        [_comicImageView setCenter:newCenter];
//    }
}

- (void)setComicImage:(UIImage *)comicImage
{
    _comicImageView.image = comicImage;
    [self bringSubviewToFront:_comicImageView];
    _addImageView.hidden = YES;
}

@end
