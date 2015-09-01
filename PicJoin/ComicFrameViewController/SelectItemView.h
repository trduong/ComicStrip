//
//  SelectItemView.h
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectItemView;

@protocol SelectItemViewDelegate <NSObject>

- (void)didSelectedItemView:(SelectItemView *)itemView;

@end

@interface SelectItemView : UIView

@property (nonatomic, assign) id <SelectItemViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

- (void)setSelectedItem:(BOOL)isSelected;

@end
