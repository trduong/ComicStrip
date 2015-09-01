//
//  SelectTypeAndBubbleView.h
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectItemView.h"
#import "ContenScrollView.h"

@class SelectTypeAndBubbleView;

@protocol SelectTypeAndBubbleViewDelegate <NSObject>

- (void)didSelectShowOrHideView:(BOOL)isShow;
- (void)didSelectedContentItem:(SelectTypeAndBubbleView *)selectTypeAndBubbleView andContentType:(ContentType)contentType andIndex:(NSInteger)index;

@end

@interface SelectTypeAndBubbleView : UIView <SelectItemViewDelegate, ContenScrollViewDelegate>

@property (nonatomic, assign) id <SelectTypeAndBubbleViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *showOrHideButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet SelectItemView *saveAndPublicItemVIew;
@property (weak, nonatomic) IBOutlet SelectItemView *addCaptionItemView;
@property (weak, nonatomic) IBOutlet SelectItemView *changeFrameItemView;
@property (nonatomic, weak) IBOutlet SelectItemView *stickerView;
@property (weak, nonatomic) IBOutlet ContenScrollView *contentScrollView;
@property (nonatomic, weak) IBOutlet UIScrollView *headerScrollView;

- (IBAction)onShowOrHideViewAction:(id)sender;

@end
