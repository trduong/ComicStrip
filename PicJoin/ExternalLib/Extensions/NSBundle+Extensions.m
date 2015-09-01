/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Common/Extensions/NSBundle+Extensions.m $
 **  $Id: NSBundle+Extensions.m 3506 2013-03-26 09:32:59Z ChinhND $
***/
//
//  NSBundle+Extensions.m
//  WISeID
//
//  Created by wisekey on 4/29/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import "NSBundle+Extensions.h"


@implementation NSBundle (Localized)
-(NSString *)localizedPathForResource:(NSString *)name ofType:(NSString *)ext
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
	NSString *currentLocalizedFolder=[currentLanguage stringByAppendingString:@".lproj"];
	
	if([self pathForResource:name ofType:ext inDirectory:currentLocalizedFolder]==nil)
	{
		currentLocalizedFolder=@"eng.lproj";
	}
	return [self pathForResource:name ofType:ext inDirectory:currentLocalizedFolder];
}
@end

