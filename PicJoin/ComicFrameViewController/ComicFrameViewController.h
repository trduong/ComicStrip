//
//  ComicFrameViewController.h
//  PicJoin
//
//  Created by steve Nam on 12/16/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "FrameManager.h"
#import "FrameObject.h"
#import "ComicItemView.h"
#import "CustomPickerController.h"
#import "SelectTypeAndBubbleView.h"

@interface ComicFrameViewController : BaseViewController <ComicItemViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SelectTypeAndBubbleViewDelegate>
{
    FrameManager *_frameManager;
    AppController *_appController;
    FrameObject *_frameObjectSelected;
    ComicItemView *_comicItemViewSelected;
}

@property (weak, nonatomic) IBOutlet SelectTypeAndBubbleView *selectTypeAndBubbleView;
@property (weak, nonatomic) IBOutlet UIView *shareTWandFBView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, retain) UIView *blurView;
@property (nonatomic, strong) UIPopoverController *popover;

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier;

@end
