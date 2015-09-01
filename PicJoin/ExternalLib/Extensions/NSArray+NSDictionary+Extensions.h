/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Common/Extensions/NSArray+NSDictionary+Extensions.h $
 **  $Id: NSArray+NSDictionary+Extensions.h 3506 2013-03-26 09:32:59Z ChinhND $
***/
//
//  NSArray+NSDictionary+Extensions.h
//  WISeID
//
//  Created by  selvakumar on 4/18/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark NSArray

@interface NSArray (NSArrayFunctions)
- (NSArray *) SortedAlphabeticArray;
- (NSArray*)sortedAlphabeticArrayUsing:(NSString *)descriptor;
- (NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString;
- (NSMutableArray *)removeObjectsContainingString:(NSString *)aString;
- (NSMutableArray*)removeObjectsWithoutString:(NSString *)aString ;
- (NSMutableArray*)removeObjectsStartsWithString:(NSString *)aString ;
-(NSArray*)arrayOfValuesForKey:(NSString*)key;
@end

/*
 * NSObject provides default implementations of -hash (which returns the address of the instance, like(NSUInteger)self) 
 * and -isEqual: (which returns NO unless the addresses of the receiver and the parameter are identical). 
 * These methods are designed to be overridden as necessary, but the documentation makes it clear that you should provide both or neither. 
 * Further, if -isEqual: returnsYES for two objects, then the result of -hash for those objects must be the same.
 */
@interface NSArray (Hash)


//- removing isEqual implementation in order to avoid issue related to #2497
//- need further investigation
// (BOOL) isEqual:(id)object;

@end

#pragma mark -