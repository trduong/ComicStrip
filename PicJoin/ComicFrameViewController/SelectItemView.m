//
//  SelectItemView.m
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "SelectItemView.h"

@implementation SelectItemView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)setSelectedItem:(BOOL)isSelected
{
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRed:135.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:0.5];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedItemView:)]) {
        [_delegate didSelectedItemView:self];
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
