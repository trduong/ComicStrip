/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Common/Extensions/NSString+Extensions.h $
 **  $Id: NSString+Extensions.h 3506 2013-03-26 09:32:59Z ChinhND $
***/
//
//  NSString_Extensions.h
//  WISeID
//
//  Created by wisekey on 4/21/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringFunctions)
-(BOOL) isAnyOf:(NSString *)Strings; 
-(NSString*) NullToBlank;
-(NSString*) quotedString;
//-(NSString*) localizedString; 
-(NSString *) truncateTrails:(NSInteger)length;
-(NSString *) ImplementBreaking:(NSInteger)length;
-(NSString *) ImplementWording:(NSInteger)length;
-(NSInteger ) numberOfLinesInString;
-(BOOL) containsString:(NSString *)str;
- (BOOL)containsAnyOf:(NSString *)Strings ;
- (BOOL)equalsAnyOf:(NSString *)Strings ;
-(NSString *) pad:(NSInteger)length;
-(BOOL) hasSubString:(NSString *) str;
-(BOOL) hasSubStringWithPattern:(NSString*) regEx;
-(BOOL) isEmpty;

+(NSString*)stringWithFloat:(float)value maxDecimal:(int)decimalLimit;
@end

@interface NSString (NSStringEncoding)
+(NSString *) base64StringFromData:(NSData *)data length:(int)length;
+(NSData *)decodeBase64StringToData:(NSString *)decodeString;
- (NSData*) getNSDataRepresentation; // get current string NSData representation using UTF8 encoding
@end

@interface NSString (JSONSerialization)
-(id)proxyForJson;
-(id)readerForJson;
@end