//
//  FrameObject.h
//  PicJoin
//
//  Created by steve Nam on 12/22/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrameObject : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *thumbImage;
@property (nonatomic, retain) NSMutableArray *regions;

@end
