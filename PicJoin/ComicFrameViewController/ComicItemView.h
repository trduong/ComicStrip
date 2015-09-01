//
//  ComicItemView.h
//  PicJoin
//
//  Created by steve Nam on 12/16/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComicItemView;

@protocol ComicItemViewDelegate <NSObject>

- (void)didSelectedChangeImage:(ComicItemView *)comicItemView;

@end

@interface ComicItemView : UIView

@property (nonatomic, assign) id <ComicItemViewDelegate> delegate;

- (void)setComicImage:(UIImage *)comicImage;

@end
