//
//  SelectTypeAndBubbleView.m
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "SelectTypeAndBubbleView.h"

@implementation SelectTypeAndBubbleView

- (void)awakeFromNib
{
    if ([Utils isIpad]) {
        _contentView.backgroundColor = [UIColor darkGrayColor];
    } else {
        _contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"drawer_BG"]];
    }
    _changeFrameItemView.delegate = self;
    _addCaptionItemView.delegate = self;
    _saveAndPublicItemVIew.delegate = self;
    _stickerView.delegate = self;
    _contentScrollView.contentDelegate = self;
    
    [_headerScrollView setContentSize:CGSizeMake(560, 80)];
}

- (IBAction)onShowOrHideViewAction:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    BOOL checked = !button.selected;
    button.selected = checked;
    if (checked) {
        [button setImage:[UIImage imageNamed:@"drawer-thumb-down"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:@"drawer-thumb-up"] forState:UIControlStateNormal];
    }
    
    [_changeFrameItemView setSelectedItem:YES];
    [_addCaptionItemView setSelectedItem:NO];
    [_saveAndPublicItemVIew setSelectedItem:NO];
    [_stickerView setSelectedItem:NO];
    [_contentScrollView loadContentWithType:ContentTypeFrame];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectShowOrHideView:)]) {
        [_delegate didSelectShowOrHideView:checked];
    }
}

#pragma mark - SelectItemViewDelegate

- (void)didSelectedItemView:(SelectItemView *)itemView
{
    switch (itemView.tag) {
        case 0:
        {
            [_changeFrameItemView setSelectedItem:YES];
            [_addCaptionItemView setSelectedItem:NO];
            [_saveAndPublicItemVIew setSelectedItem:NO];
            [_stickerView setSelectedItem:NO];
            [_contentScrollView loadContentWithType:ContentTypeFrame];
        } break;
        case 1:
        {
            [_changeFrameItemView setSelectedItem:NO];
            [_addCaptionItemView setSelectedItem:YES];
            [_saveAndPublicItemVIew setSelectedItem:NO];
            [_stickerView setSelectedItem:NO];
            [_contentScrollView loadContentWithType:ContenTypeBubble];
        } break;
        case 2:
        {
            [_changeFrameItemView setSelectedItem:NO];
            [_saveAndPublicItemVIew setSelectedItem:YES];
            [_addCaptionItemView setSelectedItem:NO];
            [_stickerView setSelectedItem:NO];
            [_contentScrollView loadContentWithType:ContentTypeShare];
        } break;
        case 3:
        {
            [_changeFrameItemView setSelectedItem:NO];
            [_saveAndPublicItemVIew setSelectedItem:NO];
            [_addCaptionItemView setSelectedItem:NO];
            [_stickerView setSelectedItem:YES];
            [_contentScrollView loadContentWithType:ContentTypeSticker];
        } break;
            
        default:
            break;
    }
}

#pragma mark - ContenScrollViewDelegate

- (void)didSelectContentItem:(ContentType)contentType andIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedContentItem:andContentType:andIndex:)]) {
        [_delegate didSelectedContentItem:self andContentType:contentType andIndex:index];
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
