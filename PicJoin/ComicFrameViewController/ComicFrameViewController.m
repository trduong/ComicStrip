//
//  ComicFrameViewController.m
//  PicJoin
//
//  Created by steve Nam on 12/16/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "ComicFrameViewController.h"
#import "Utils.h"
#import "StickerView.h"
#import "AppDelegate.h"
#import "VMEditView.h"
#import "VMBubbleOval.h"
#import "VMColorPickerView.h"
#import "STTwitterAPI.h"
#import "SVProgressHUD.h"
#import "SVModalWebViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define kOAuthConsumerKey                   @"V4X2Ghpn0ypkAmwychJnAxxe5"
#define kOAuthConsumerSecret                @"15J5zXZrWW7G0rjKdDE84bu1PQ5BnBzWwTJUKartznWOJhwPLn"
#define Twitter_OAuth_Data                  @"com.comicstrip.Twitter_OAuth_Data"

@interface ComicFrameViewController () <VMBubbleOvalDelegate, VMEditViewDelegate, VMColorPickerViewDelegate, UIDocumentInteractionControllerDelegate>
{
    STTwitterAPI *_twitter;
    BOOL _isPostFB;
    BOOL _isPostTW;
}

@property (nonatomic) BOOL isShowMenuBubble;
@property (nonatomic) BOOL isShowEditBubble;
@property (nonatomic) BOOL isShowColorPicker;
@property (nonatomic) NSInteger numOfBubbleOvalInView;
@property (nonatomic, strong) UIButton *panView;
@property (nonatomic) NSInteger tagCurrentView;
@property (nonatomic) NSInteger tagCurrentAfterHide;
@property (nonatomic) CGPoint currentCenterAfterEditText;
@property (nonatomic) NSInteger heightOfKeyboard;
@property (nonatomic) CGPoint currentCenter;
@property (nonatomic, strong) VMEditView *editView;
@property (nonatomic, strong) VMColorPickerView *colorPicker;
@property (nonatomic) NSInteger typeOfChange;

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation ComicFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _appController = [AppController sharedInstance];
    if ([Utils isIphone35Inch]) {
        _frameManager = [_appController getFramesDataFromFile:@"Frame_Ip4"];
    } else if ([Utils isIphone4Inch]) {
        _frameManager = [_appController getFramesDataFromFile:@"Frame_Ip5"];
    } else if ([Utils isIpad]){
        _frameManager = [_appController getFramesDataFromFile:@"Frame_iPad"];
    }
    _frameObjectSelected = [_frameManager frameObjectAtIndex:0];
    
    [self drawCommicItemView:_frameObjectSelected];
    _selectTypeAndBubbleView.delegate = self;
    
    [self setup];
    [_selectTypeAndBubbleView setAccessibilityLabel:@"selectAndHideView"];


}

- (void)viewWillAppear:(BOOL)animated
{
    _shareTWandFBView.layer.cornerRadius = 5;
    _shareTWandFBView.layer.masksToBounds = YES;
    _shareTWandFBView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - Action

- (void)clearItemView
{
    for (UIView *itemView in self.view.subviews) {
        if ([itemView isKindOfClass:[ComicItemView class]]) {
            [itemView removeFromSuperview];
        }
    }
}

- (void)drawCommicItemView:(FrameObject *)frameObject
{
    for (NSString *stringItem in frameObject.regions) {
        CGRect rectItem = CGRectFromString(stringItem);
        ComicItemView *itemView = [[ComicItemView alloc] initWithFrame:rectItem];
        itemView.delegate = self;
        [self.view addSubview:itemView];
    }
    
    for (UIView *vi  in self.view.subviews) {
        if ([vi isKindOfClass:[VMBubbleOval class]] || [vi isKindOfClass:[StickerView class]] || [vi isKindOfClass:[VMColorPickerView class]] || [vi isKindOfClass:[VMEditView class]]) {
            [self.view bringSubviewToFront:vi];
        }
    }
    
    [self.view bringSubviewToFront:_selectTypeAndBubbleView];
}

- (UIImage *)exportImage
{
    [self hideColorPicker];
    [self hideEditBubble];
    [self hiddenPostView];
    
    _selectTypeAndBubbleView.hidden = YES;
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect cropRect = CGRectMake(0, 0, self.view.bounds.size.width * 2, self.view.bounds.size.height * 2);
    UIGraphicsBeginImageContextWithOptions(cropRect.size, self.view.opaque, 1.0f);
    [screenshot drawInRect:cropRect];
    UIImage *customScreenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _selectTypeAndBubbleView.hidden = NO;

    return  customScreenShot;
}

#pragma mark - ComicItemViewDelegate

- (void)didSelectedChangeImage:(ComicItemView *)comicItemView
{
    [_appController hidePinBalloonNotification];

    if (_comicItemViewSelected) {
        _comicItemViewSelected = nil;
    }
    _comicItemViewSelected = comicItemView;
    [self.view endEditing:YES];
    [self hideEditBubble];
    [self hideColorPicker];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pick from library", @"Take photo", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    
    CustomPickerController *imagePicker = [[CustomPickerController alloc] init];
    imagePicker.modalPresentationStyle = [Utils isIpad] ? UIModalPresentationPopover : UIModalPresentationFormSheet;
    imagePicker.delegate = self;
    switch (buttonIndex) {
        case 1:
        {
            NSLog(@"Take photo");
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } break;
        case 2:
        {
            NSLog(@"Library");
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        } break;
        default:
            break;
    }
    
    if ([Utils isIpad]) {
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                [popover presentPopoverFromRect:_comicItemViewSelected.bounds inView:_comicItemViewSelected permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                _popover = popover;
            }];
        } else {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            [popover presentPopoverFromRect:_comicItemViewSelected.bounds inView:_comicItemViewSelected permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            _popover = popover;
        }
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

#pragma mark - Picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{

    [_comicItemViewSelected setComicImage:img];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SelectTypeAndBubbleViewDelegate

- (void)didSelectShowOrHideView:(BOOL)isShow
{
    [self.view bringSubviewToFront:_selectTypeAndBubbleView];
    [self hideColorPicker];
    [self.view endEditing:YES];
    [self hideEditBubble];
    
    CGRect rect = _selectTypeAndBubbleView.frame;
    if (isShow) {
        rect.origin.y = self.view.frame.size.height - rect.size.height;
    } else {
        rect.origin.y = self.view.frame.size.height - 30;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    _selectTypeAndBubbleView.frame = rect;
    [UIView commitAnimations];
}

- (void)didSelectedContentItem:(SelectTypeAndBubbleView *)selectTypeAndBubbleView andContentType:(ContentType)contentType andIndex:(NSInteger)index
{
    if (contentType == ContentTypeFrame) {
        [self clearItemView];
        _frameObjectSelected = [_frameManager frameObjectAtIndex:index];
        [self drawCommicItemView:_frameObjectSelected];
    } else if (contentType == ContenTypeBubble) {
        if (index <= 7) {
            switch (index) {
                case 0:
                {
                    [self makeBubbleWithType:1];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 1:
                {
                    [self makeBubbleWithType:2];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 2:
                {
                    [self makeBubbleWithType:3];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 3:
                {
                    [self makeBubbleWithType:4];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 4:
                {
                    [self makeBubbleWithType:5];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 5:
                {
                    [self makeBubbleWithType:6];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 6:
                {
                    [self makeBubbleWithType:7];
                    self.numOfBubbleOvalInView += 1;
                } break;
                case 7:
                {
                    [self makeBubbleWithType:8];
                    self.numOfBubbleOvalInView += 1;
                } break;
                    
                default:
                    break;
            }
        }
    } else if (contentType == ContentTypeSticker) {
        StickerView *stickerView = (StickerView *)[Utils viewFromNibNamed:@"StickerView"];
        stickerView.center = CGPointMake(self.view.center.x , self.view.center.y - 20);
        stickerView.backgroundImageView.image = [[AppDelegate sharedInstance].stickerArray objectAtIndex:index];
        [self.view insertSubview:stickerView belowSubview:_selectTypeAndBubbleView];
    } else {
        switch (index) {
            case 0:
            {
                NSLog(@"Share FB");
                _isPostFB = YES;
                _isPostTW = NO;
                
                [self showPostView];
            } break;
            case 1:
            {
                NSLog(@"Share TW");
                if ([self isUserAuthenticated]) {
                    _isPostTW = YES;
                    _isPostFB = NO;
                    [self showPostView];
                } else {
                    [self loginOnTheWeb];
                }
            } break;
            case 2:
            {
                NSLog(@"Share Ins");
                [self shareInstagram];
            } break;
            case 3:
            {
                NSLog(@"Save local");
                UIImageWriteToSavedPhotosAlbum([self exportImage], nil, nil, nil);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Save image to photo library success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            } break;
                
            default:
                break;
        }
    }
    
    [_selectTypeAndBubbleView onShowOrHideViewAction:_selectTypeAndBubbleView.showOrHideButton];
}

- (void)loginOnTheWeb
{
    [SVProgressHUD show];
    _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kOAuthConsumerKey
                                             consumerSecret:kOAuthConsumerSecret];
    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        [SVProgressHUD dismiss];
        SVModalWebViewController *webViewVC = [[SVModalWebViewController alloc] initWithURL:url];
        
        [self presentViewController:webViewVC animated:YES completion:^{
            
        }];
        
    } authenticateInsteadOfAuthorize:NO
                    forceLogin:@(YES)
                    screenName:nil
                 oauthCallback:@"comicstripApp://twitter_access_tokens/"
                    errorBlock:^(NSError *error) {
                        NSLog(@"-- error: %@", error);
                        
                    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    [SVProgressHUD show];
    
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        NSString *saveToken = [NSString stringWithFormat:@"oauth_token=%@&oauth_token_secret=%@&user_id=%@&screen_name=%@", oauthToken, oauthTokenSecret, userID, screenName];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:saveToken forKey:Twitter_OAuth_Data];
        [defaults synchronize];
        
        _isPostTW = YES;
        [SVProgressHUD dismiss];
        [self showPostView];
        
    } errorBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)showPostView
{
    if (_isPostFB) {
        _titleLabel.text = @"Facebook";
    }
    
    if (_isPostTW) {
        _titleLabel.text = @"Twitter";
    }
    
    [self addBlurView];
    [self.view bringSubviewToFront:_shareTWandFBView];
    _shareTWandFBView.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        if ([Utils isIpad]) {
            _shareTWandFBView.frame = CGRectMake((self.view.bounds.size.width - 500)/2, 0, 500, 400);
        } else {
            _shareTWandFBView.frame = CGRectMake((self.view.bounds.size.width - 280)/2, 0, 280, 240);
        }
    } completion:^(BOOL finished) {
        _contentTextView.text = @"ComicStrip";
        [_contentTextView becomeFirstResponder];
    }];
}

- (void)hiddenPostView
{
    _isPostFB = NO;
    _isPostTW = NO;
    [_contentTextView resignFirstResponder];
    [self removeBlurView];
    _shareTWandFBView.hidden = YES;
    if ([Utils isIpad]) {
        _shareTWandFBView.frame = CGRectMake((self.view.bounds.size.width - 500)/2, 100, 500, 400);
    } else {
        _shareTWandFBView.frame = CGRectMake((self.view.bounds.size.width - 280)/2, 100, 280, 240);
    }
}

- (void)shareFacebook
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
    [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                       defaultAudience:FBSessionDefaultAudienceOnlyMe
                                          allowLoginUI:YES
                                     completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                         if (!error && status == FBSessionStateOpen) {
                                             [FBSession setActiveSession:session];
                                             [self postToWallFacebook];
                                         } else {
                                             NSLog(@"error");
                                             if (error) {
                                                 [self hiddenPostView];
                                                 [SVProgressHUD dismiss];
                                                 [self presentSimpleAlertMessage:@"Share Faild"];
                                             } else {
                                                 [FBSession setActiveSession:session];
                                                 [self postToWallFacebook];
                                             }
                                         }
                                     }];
}

- (void)postToWallFacebook
{
    NSData* imageData = UIImageJPEGRepresentation([self exportImage], 90);

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _contentTextView.text, @"message",
                                   imageData, @"source",
                                   nil];
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         [self hiddenPostView];
         if (error) {
             [SVProgressHUD dismiss];
             [self presentSimpleAlertMessage:@"Share Facebook error!"];
         } else {
             [self shareFBDidSuccess];
         }
     }];
}

- (void)shareFBDidSuccess
{
    [SVProgressHUD showSuccessWithStatus:@"Shared Facebok successfully"];
}

#pragma mark - BlurView

- (void)addBlurView
{
    [self removeBlurView];
    _blurView = [[UIView alloc] initWithFrame:self.view.bounds];
    _blurView.backgroundColor = [UIColor blackColor];
    _blurView.alpha = 0.6f;
    [self.view addSubview:_blurView];
}

- (void)removeBlurView
{
    if (_blurView) {
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
}

- (BOOL)isUserAuthenticated
{
    if ([self loadToken]) {
        return YES;
    }
    return NO;
}

- (NSString *)loadToken
{
    //- load token from user preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id token = [defaults objectForKey:Twitter_OAuth_Data];
    if ([token isKindOfClass:[NSString class]]) {
        NSString *strToken = (NSString *)token;
        NSArray *dataArray = [strToken componentsSeparatedByString:@"&"];
        if (dataArray.count >= 4) {
            return strToken;
        }
    }
    
    return nil;
}

#pragma mark - Share

- (void)shareInstagram
{
    if ([self canPerformInstagram]) {
        [self performPostImageToInstagram];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You will need to download the instagram app to proceed." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alertView show];
    }
}

- (BOOL)canPerformInstagram
{
    NSURL *instagramUrl = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramUrl]) {
        return YES;
    }
    
    return NO;
}

- (void)performPostImageToInstagram
{
    NSString *hastagText = @"ComicStrip";
    
    UIImage *shareImage = [self exportImage];

    UIImageView *instagramImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    instagramImageView.backgroundColor = [UIColor blackColor];
    instagramImageView.contentMode = UIViewContentModeScaleAspectFit;
    instagramImageView.image = [UIImage imageWithCGImage:shareImage.CGImage scale:shareImage.scale orientation:UIImageOrientationUp];
    
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    CGFloat imageWidth = instagramImageView.image.size.width;
    CGFloat imageHeight = instagramImageView.image.size.height;
    
    CGFloat screenWidth = 640;
    CGFloat screenHeight = 640;
    
    CGFloat imageRatio = 1;
    CGFloat imageWidthToScale = 1;
    CGFloat imageHeightToScale = 1;
    
    imageRatio = imageHeight/imageWidth;
    imageWidthToScale = screenWidth;
    imageHeightToScale = screenHeight * imageRatio;
    
    UIGraphicsBeginImageContextWithOptions( (CGSize){ 640, 640 }, YES, screenScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [instagramImageView.backgroundColor setFill];
    CGContextFillRect(context, (CGRect){{0,0},{640,640}});
    CGContextTranslateCTM(context, 320, 320);
    
    [instagramImageView.image drawInRect:CGRectMake(-320, -185, imageWidthToScale, imageHeightToScale)];
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(newImage);
    
    NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
    if (![imageData writeToFile:writePath atomically:YES]) {
        // failure
        NSLog(@"image save failed to path %@", writePath);
        return;
    } else {
        // success.
    }
    
    // send it to instagram.
    NSURL *fileURL = [NSURL fileURLWithPath:writePath];
    _documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    _documentController.UTI = @"com.instagram.exclusivegram";
    _documentController.annotation = @{@"InstagramCaption" : hastagText};
    _documentController.delegate = self;
    [_documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}

- (void)postTwitter
{
    NSString *authDataStr = [[NSUserDefaults standardUserDefaults] objectForKey:Twitter_OAuth_Data];
    NSArray *subAuthDataStrs = [authDataStr componentsSeparatedByString:@"&"];
    NSString *oauthToken = [[[subAuthDataStrs objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
    NSString *oauthTokenSecret = [[[subAuthDataStrs objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:1];
    _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:@"iOS" consumerKey:kOAuthConsumerKey consumerSecret:kOAuthConsumerSecret oauthToken:oauthToken oauthTokenSecret:oauthTokenSecret];
    NSString *statusStr = [NSString stringWithFormat:@"%@", _contentTextView.text];
    [_twitter postStatusUpdate:statusStr inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
        [SVProgressHUD showSuccessWithStatus:@"Shared successfully"];
        [self hiddenPostView];
    } errorBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        if (error.code == 187) {
            [self presentSimpleAlertMessage:error.localizedDescription];
            
        } else {
            [self presentSimpleAlertMessage:@"Failed to share. Please try again"];
        }
    }];
    
}

- (IBAction)onCancelShareAction:(id)sender
{
    [SVProgressHUD dismiss];
    [self hiddenPostView];
}

- (IBAction)onPostAction:(id)sender
{
    [SVProgressHUD show];
    if (_isPostTW) {
        [self postTwitter];
    } else if (_isPostFB) {
        [self shareFacebook];
    }
}

- (void)presentSimpleAlertMessage:(NSString *)message
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:nil message:message
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"documentInteractionControllerDidDismissOptionsMenu");
}

#pragma mark - Bubble

- (void)setup
{
    self.numOfBubbleOvalInView = 0;
    self.isShowMenuBubble = NO;
    self.isShowEditBubble = NO;
    self.isShowColorPicker = NO;
    self.heightOfKeyboard = 216;
    [self initCirclePanView];
    [self initView];
    [self initEditView];
    [self hideEditBubble];
    [self initColorPicker];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)initEditView
{
    self.editView = [[VMEditView alloc] initWithFrame:CGRectMake(0, 0, 225, 40)];
    [self.editView setDelegate:self];
    [self.view addSubview:self.editView];
}

- (void)initView
{
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMainView:)];
    [self.view addGestureRecognizer:tap];
}

- (void)initColorPicker
{
    self.colorPicker = [[VMColorPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-100, self.view.bounds.size.width, 100)];
    [self.colorPicker setDelegate:self];
    [self.colorPicker setAlpha:0];
    [self.view addSubview:self.colorPicker];
    [self.view bringSubviewToFront:self.colorPicker];
}

- (void)initCirclePanView
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    
    self.panView = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.panView setImage:[UIImage imageNamed:@"IconMove.png"] forState:UIControlStateNormal];
    [self.panView addGestureRecognizer:pan];
    
    [self.view addSubview:self.panView];
}

- (void)showEditBubble
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu showPanResizeView];
            break;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.editView setAlpha:1];
        [self.panView setAlpha:1];
    } completion:^(BOOL finished) {
        self.isShowEditBubble = YES;
    }];
}

- (void)hideEditBubble
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView && vi.tag != 0) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu hidePanResizeView];
            break;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.editView setAlpha:0];
        [self.panView setAlpha:0];
    } completion:^(BOOL finished) {
        self.isShowEditBubble = NO;
    }];
}

- (void)showColorPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.colorPicker setAlpha:1];
    } completion:^(BOOL finished) {
        self.isShowColorPicker = YES;
    }];
}

- (void)hideColorPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.colorPicker setAlpha:0];
    } completion:^(BOOL finished) {
        self.isShowColorPicker = NO;
    }];
}

- (void)clickMainView:(UITapGestureRecognizer*)tap
{
    [self hideEditBubble];
    [self hideColorPicker];
    [self.view endEditing:YES];

}

- (void)makeBubbleWithType:(NSInteger)type
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveBubble:)];
    VMBubbleOval *draw = [[VMBubbleOval alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    
    draw.backgroundColor = [UIColor whiteColor];
    draw.boderColor = [UIColor blackColor];
    draw.typeOfBubble = type;
    [draw initBubbleOval];
    [draw setDelegate:self];
    [draw addGestureRecognizer:pan];
    [draw setTag:2000 + self.numOfBubbleOvalInView];
    [draw setUserInteractionEnabled:YES];
    [self.view addSubview:draw];
}

- (void)move:(UIPanGestureRecognizer*)pan
{
    if( pan.state == UIGestureRecognizerStateChanged) {
        pan.view.center = [pan locationInView:self.view];
        
        for (UIView *vi  in self.view.subviews) {
            if (vi.tag == self.tagCurrentView) {
                VMBubbleOval*drawBu = (VMBubbleOval*)vi;
                [drawBu moveArrowWithCenterPanView:[drawBu convertPoint:pan.view.center fromView:self.view]];
            }
        }
    }
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        for (UIView *vi  in self.view.subviews) {
            if (vi.tag == self.tagCurrentView) {
                VMBubbleOval*drawBu = (VMBubbleOval*)vi;
                [drawBu setCenterOfPanView];
            }
        }
        
    }
}

- (void)moveBubble:(UIPanGestureRecognizer*)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.tagCurrentView = pan.view.tag;
        [self.view bringSubviewToFront:pan.view];
        [self.view bringSubviewToFront:self.panView];
        [self.view bringSubviewToFront:self.editView];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        for (UIView *vi  in self.view.subviews) {
            if (vi.tag == self.tagCurrentView) {
                VMBubbleOval*drawBu = (VMBubbleOval*)vi;
                drawBu.center = [pan locationInView:self.view];
                [self.panView setCenter:[drawBu returnCenterLocationView]];
                [self.editView setCenter:CGPointMake(drawBu.center.x, drawBu.center.y - drawBu.bounds.size.height/2 - self.editView.bounds.size.height/2)];
                self.currentCenter = drawBu.center;
                if (drawBu.typeOfBubble == 8) {
                    [self.panView setAlpha:0];
                }
                
            }
        }
    }
}

#pragma mark - VMBubble Delegate

- (void)getCenterArrowInView:(VMBubbleOval *)bubbleTest withCenter:(CGPoint)ct
{
    self.currentCenter = bubbleTest.center;
    
    [self.panView setCenter:ct];
    [self.editView setCenter:CGPointMake(bubbleTest.center.x, bubbleTest.center.y - bubbleTest.bounds.size.height/2 - self.editView.bounds.size.height/2)];
    self.tagCurrentView = bubbleTest.tag;
    
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag != self.tagCurrentView && vi.tag >= 2000 &&vi.tag <= 2100) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu hidePanResizeView];
        }
        if (vi.tag == self.tagCurrentView && vi.tag >= 2000 &&vi.tag <= 2100) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu showPanResizeView];
        }
    }
    
    if (!self.isShowEditBubble) {
        [self showEditBubble];
        
    }
    
    if (bubbleTest.typeOfBubble == 8) {
        [self.panView setAlpha:0];
    }
    
}

- (void)changeAllViewWheResize:(VMBubbleOval *)bubbleTest withCenter:(CGPoint)ct
{
    [self.panView setCenter:ct];
    [self.editView setCenter:CGPointMake(bubbleTest.center.x, bubbleTest.center.y - bubbleTest.bounds.size.height/2 - self.editView.bounds.size.height/2)];
    self.tagCurrentView = bubbleTest.tag;
}

- (void)hidekeyboardInView:(VMBubbleOval *)bubbleTest
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView) {
            
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [UIView animateWithDuration:0.3 animations:^{
                drawBu.center = self.currentCenterAfterEditText;
                [self.panView setCenter:[drawBu returnCenterLocationView]];
                [self.editView setCenter:CGPointMake(drawBu.center.x, drawBu.center.y - drawBu.bounds.size.height/2 - self.editView.bounds.size.height/2)];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)getCenterView:(VMBubbleOval *)bubbleTest
{
    self.currentCenter = bubbleTest.center;
}

- (void)setCenterWhenResizeView:(VMBubbleOval *)bubbleTest
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == bubbleTest.tag) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu setCenter:CGPointMake(self.currentCenter.x,self.currentCenter.y)];
        }
    }
}

#pragma mark - VMEditView delegate

- (void)VMEditViewClickButBackgroundColor:(VMEditView *)editView
{
    [self.view endEditing:YES];
    [self showColorPicker];
    self.typeOfChange = 2;
    [self.colorPicker setPikerName:@"Background Color"];
}

- (void)VMEditViewClickButBoderColor:(VMEditView *)editView
{
    [self.view endEditing:YES];
    [self showColorPicker];
    self.typeOfChange = 3;
    [self.colorPicker setPikerName:@"Boder Color"];
}

- (void)VMEditViewClickButContentText:(VMEditView *)editView
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView) {
            
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu editTextWithKeyboard];
            self.currentCenterAfterEditText = drawBu.center;
            NSLog(@"current center : %f, hehehehe: %f ",drawBu.center.y, (CGRectGetHeight(self.view.frame) - self.heightOfKeyboard));
            if (drawBu.center.y >= (CGRectGetHeight(self.view.frame) - self.heightOfKeyboard - 50))
            {
                [UIView animateWithDuration:0.3 animations:^{
                    drawBu.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2-70);
                    [self.panView setCenter:[drawBu returnCenterLocationView]];
                    [self.editView setCenter:CGPointMake(drawBu.center.x, drawBu.center.y - drawBu.bounds.size.height/2 - self.editView.bounds.size.height/2)];
                } completion:^(BOOL finished) {
                    
                }];
            }
            
            break;
        }
    }
}

- (void)VMEditViewClickButRemove:(VMEditView *)editView
{
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView) {
            VMBubbleOval*drawBu = (VMBubbleOval*)vi;
            [drawBu removeFromSuperview];
            break;
        }
    }
    [self.view endEditing:YES];
    [self hideEditBubble];
}

- (void)VMEditViewClickButTextColor:(VMEditView *)editView
{
    [self.view endEditing:YES];
    [self showColorPicker];
    self.typeOfChange = 1;
    [self.colorPicker setPikerName:@"Text Color"];
}

#pragma mark - color picker view delegate

- (void)VMColorPickerViewClickReturnColor:(VMColorPickerView *)colorPicker withReturnColor:(UIColor *)color
{
    NSLog(@"Color return:");
    VMBubbleOval*drawBu;
    for (UIView *vi  in self.view.subviews) {
        if (vi.tag == self.tagCurrentView) {
            drawBu = (VMBubbleOval*)vi;
            break;
        }
    }
    
    switch (self.typeOfChange) {
        case 1:
            [drawBu.textView setTextColor:color];
            break;
        case 2:
            [drawBu setBackgroundColor:color];
            [drawBu changeBackgroundColor];
            break;
        case 3:
            [drawBu setBoderColor:color];
            [drawBu changeBoderColor];
            break;
        default:
            break;
    }
}

#pragma mark - keyboard

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.heightOfKeyboard = MIN(keyboardSize.height,keyboardSize.width);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
