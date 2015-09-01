//
//  ContenScrollView.h
//  PicJoin
//
//  Created by steve Nam on 12/23/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameManager.h"
#import "FrameObject.h"
#import "AppController.h"

typedef enum {
    ContentTypeFrame = 0,
    ContenTypeBubble = 1,
    ContentTypeShare = 2,
    ContentTypeSticker = 3
} ContentType;

@protocol ContenScrollViewDelegate <NSObject>

- (void)didSelectContentItem:(ContentType)contentType andIndex:(NSInteger)index;

@end

@interface ContenScrollView : UIScrollView
{
    NSMutableArray *_listBuble;
    AppController *_appController;
    FrameManager *_frameManager;
    ContentType _currentContentType;
    UIImageView *_hightLightImageView;
    NSInteger _selectedIndex;
    NSMutableArray *_balloonArray;
    UIView *_balloonListView;
    CGFloat _scrollBalloonWidth;
    NSMutableArray *_stickerArray;
    UIView *_stickerListView;
    CGFloat _scrollStickerWidth;
    UIView *_frameListView;
    CGFloat _scrollFrameWidth;
    UIView *_shareView;
    CGFloat _scrollShareWidth;
}

@property (nonatomic, assign) id <ContenScrollViewDelegate> contentDelegate;

- (void)loadContentWithType:(ContentType)contentType;
- (void)clearView;

@end
