//
//  InputTextBalloonView.h
//  PicJoin
//
//  Created by steve Nam on 12/27/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputTextBalloonViewDelegate <NSObject>

- (void)didFinishInputTextBalloon:(NSString *)contentText andIndex:(NSInteger)index;

@end

@interface InputTextBalloonView : UIView

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (nonatomic, assign) id <InputTextBalloonViewDelegate> delegate;
@property (nonatomic, assign) NSInteger index;

@end
