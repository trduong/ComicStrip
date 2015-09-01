//
//  InputTextBalloonView.m
//  PicJoin
//
//  Created by steve Nam on 12/27/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "InputTextBalloonView.h"

@implementation InputTextBalloonView

- (void)awakeFromNib
{
    
}

- (IBAction)onDoneAction:(id)sender
{
    [_inputTextView resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishInputTextBalloon:andIndex:)]) {
        [_delegate didFinishInputTextBalloon:_inputTextView.text andIndex:_index];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
