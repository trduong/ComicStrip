//
//  ContenScrollView.m
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "ContenScrollView.h"
#import "AppDelegate.h"

@implementation ContenScrollView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:135.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:0.5];
    self.bounces = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    _currentContentType = ContentTypeFrame;
    _selectedIndex = 0;
    
    [self initFrameView];
    [self initBalloonView];
    [self initStickerView];
    [self initShareView];
}

- (void)initBalloonView
{
    _balloonArray = [AppDelegate sharedInstance].balloonArray;
    _balloonListView = [[UIView alloc] init];
    _scrollBalloonWidth = 0;
    for (int i = 0; i < [_balloonArray count]; i++) {
        UIImage *balloonItem = [_balloonArray objectAtIndex:i];
        UIImageView *balloonItemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*90 + 70, 10, 70, 70)];
        balloonItemImageView.image = balloonItem;
        balloonItemImageView.tag = i;
        balloonItemImageView.userInteractionEnabled = YES;
        
        _scrollBalloonWidth += 90;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [balloonItemImageView addGestureRecognizer:tap];
        [_balloonListView addSubview:balloonItemImageView];
    }
    
    _balloonListView.frame = CGRectMake(0, 0, _scrollBalloonWidth + 200, 100);
    [self addSubview:_balloonListView];
    _balloonListView.hidden = YES;
}

- (void)initStickerView
{
    _stickerArray = [AppDelegate sharedInstance].stickerArray;
    _stickerListView = [[UIView alloc] init];
    _scrollStickerWidth = 0;
    for (int i = 0; i < [_stickerArray count]; i++) {
        UIImage *stickerItem = [_stickerArray objectAtIndex:i];
        UIImageView *stickerItemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*90 + 70, 10, 70, 70)];
        stickerItemImageView.image = stickerItem;
        stickerItemImageView.tag = i;
        stickerItemImageView.userInteractionEnabled = YES;
        
        _scrollStickerWidth += 90;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [stickerItemImageView addGestureRecognizer:tap];
        [_stickerListView addSubview:stickerItemImageView];
    }
    
    _stickerListView.frame = CGRectMake(0, 0, _scrollStickerWidth + 200, 100);
    [self addSubview:_stickerListView];
    _stickerListView.hidden = YES;
}

- (void)initShareView
{
    NSArray *shareImageArr = [NSArray arrayWithObjects:@"facebook_icon", @"twitter_icon", @"instagram_icon", @"save_icon", nil];
    _shareView = [[UIView alloc] init];
    for (int i = 0; i < [shareImageArr count]; i++) {
        NSString *shareItemName = [shareImageArr objectAtIndex:i];
        UIImageView *shareItemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*84 + 64, 20, 64, 64)];
        shareItemImageView.image = [UIImage imageNamed:shareItemName];
        shareItemImageView.tag = i;
        shareItemImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [shareItemImageView addGestureRecognizer:tap];
        [_shareView addSubview:shareItemImageView];
    }
    
    _scrollShareWidth = [shareImageArr count]*84 + 100;
    _shareView.frame = CGRectMake(0, 0, _scrollShareWidth, 100);
    [self addSubview:_shareView];
    CGPoint centerPoint = _shareView.center;
    centerPoint.x = self.center.x;
    _shareView.center = centerPoint;
    _shareView.hidden = YES;
}

- (void)initFrameView
{
    _appController = [AppController sharedInstance];
    _frameManager = [_appController getFramesDataFromFile:@"Frame_Ip4"];
    _frameListView = [[UIView alloc] init];

    for (int i = 0; i < [_frameManager count]; i++) {
        FrameObject *frameObj = [_frameManager frameObjectAtIndex:i];
        UIImage *thumbItem = [UIImage imageNamed:frameObj.thumbImage];
        UIImageView *frameItem = [[UIImageView alloc] initWithFrame:CGRectMake(i*thumbItem.size.width + thumbItem.size.width/2 , 10, thumbItem.size.width, thumbItem.size.height)];
        frameItem.image = thumbItem;
        frameItem.tag = i;
        frameItem.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [frameItem addGestureRecognizer:tap];
        
        [_frameListView addSubview:frameItem];
    }
    
    FrameObject *frameFirst = [_frameManager frameObjectAtIndex:0];
    UIImage *thumbItemFirst = [UIImage imageNamed:frameFirst.thumbImage];
    _scrollFrameWidth = thumbItemFirst.size.width * [_frameManager count] + thumbItemFirst.size.width;
    _frameListView.frame = CGRectMake(0, 0, _scrollFrameWidth, 100);
    [self addSubview:_frameListView];
    _frameListView.hidden = YES;
}

- (void)loadContentWithType:(ContentType)contentType
{
    [self clearView];
    switch (contentType) {
        case ContentTypeFrame:
        {
            _frameListView.hidden = NO;
            _currentContentType = ContentTypeFrame;
            UIImageView *imageViewSelected = (UIImageView *)[_frameListView.subviews objectAtIndex:_selectedIndex];
            [self addHightLightImageView:imageViewSelected];
            [self setContentSize:CGSizeMake(_scrollFrameWidth, 100)];
            
        } break;
        case ContenTypeBubble:
        {
            _balloonListView.hidden = NO;
            _currentContentType = ContenTypeBubble;
            [self setContentSize:CGSizeMake(_scrollBalloonWidth + 200, 100)];

        } break;
        case ContentTypeShare:
        {
            _shareView.hidden = NO;
            _currentContentType = ContentTypeShare;
            [self setContentSize:CGSizeMake(_scrollShareWidth, 100)];
        } break;
        case ContentTypeSticker:
        {
            _stickerListView.hidden = NO;
            _currentContentType = ContentTypeSticker;
            [self setContentSize:CGSizeMake(_scrollStickerWidth + 200, 100)];
        } break;
        default:
            break;
    }
}

- (void)clearView
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (_shareView) {
        _shareView.hidden = YES;
    }
    
    if (_frameListView) {
        _frameListView.hidden = YES;
    }
    
    if (_balloonListView) {
        _balloonListView.hidden = YES;
    }
    
    if (_stickerListView) {
        _stickerListView.hidden = YES;
    }
    
    [self setContentOffset:CGPointMake(0.0, 0.0)];
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    UIImageView *imageViewSelected = (UIImageView *)gesture.view;
    if (_currentContentType == ContentTypeFrame) {
        _selectedIndex = imageViewSelected.tag;
    }
    [self addHightLightImageView:imageViewSelected];
    if (_contentDelegate && [_contentDelegate respondsToSelector:@selector(didSelectContentItem:andIndex:)]) {
        [_contentDelegate didSelectContentItem:_currentContentType andIndex:imageViewSelected.tag];
    }
}

- (void)addHightLightImageView:(UIImageView *)imageSelected
{
    if (_hightLightImageView) {
        [_hightLightImageView removeFromSuperview];
        _hightLightImageView = nil;
    }
    
    _hightLightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_post_highlight"]];
    _hightLightImageView.frame = CGRectMake((imageSelected.frame.size.width /2 + imageSelected.frame.size.width * imageSelected.tag -3), 10, imageSelected.frame.size.width + 6, imageSelected.frame.size.height);
    [_frameListView addSubview:_hightLightImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
