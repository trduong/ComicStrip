//
//  VMBubbleOval.h
//  Picapp
//
//  Created by Vu Mai on 4/11/15.
//  Copyright (c) 2015 VuMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMFrameOval.h"
#import "VMArrowBorderOval.h"
#import "VMArrowOval.h"

@protocol VMBubbleOvalDelegate;

@interface VMBubbleOval : UIView<UITextViewDelegate>

@property (nonatomic) id<VMBubbleOvalDelegate>delegate;
-(void)initBubbleOval;
-(void)initTextbox;

-(void)setCenterOfPanView;
-(void)moveArrowWithCenterPanView:(CGPoint)center;
-(CGPoint)returnCenterLocationView;

@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *boderColor;
@property (nonatomic) UITextView *textView;
@property (nonatomic) NSInteger typeOfBubble;

-(void)editTextWithKeyboard;
-(void)showPanResizeView;
-(void)hidePanResizeView;
-(void)changeBackgroundColor;
-(void)changeBoderColor;


@end

@protocol VMBubbleOvalDelegate <NSObject>

@optional
-(void)getCenterArrowInView:(VMBubbleOval*)bubbleTest withCenter:(CGPoint)ct;
-(void)changeAllViewWheResize:(VMBubbleOval*)bubbleTest withCenter:(CGPoint)ct;
-(void)hidekeyboardInView:(VMBubbleOval*)bubbleTest;
-(void)setCenterWhenResizeView:(VMBubbleOval*)bubbleTest;
-(void)getCenterView:(VMBubbleOval*)bubbleTest;
@end