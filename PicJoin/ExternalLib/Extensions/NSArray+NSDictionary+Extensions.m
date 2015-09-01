/***
 **  $Date: 2013-03-26 16:32:59 +0700 (Tue, 26 Mar 2013) $
 **  $Revision: 3506 $
 **  $Author: ChinhND $
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/Libs/WISeKey/Common/Extensions/NSArray+NSDictionary+Extensions.m $
 **  $Id: NSArray+NSDictionary+Extensions.m 3506 2013-03-26 09:32:59Z ChinhND $
***/
//
//  NSArray+NSDictionary+Extensions.m
//  WISeID
//
//  Created by selvakumar on 4/18/11.
//  Copyright 2011 WISeKey SA, All rights reserved.
//

#import "NSArray+NSDictionary+Extensions.h"
#import "NSString+Extensions.h"

#pragma mark NSArray

@implementation NSArray (NSArrayFunctions)

-(NSArray*)SortedAlphabeticArray
{
	//Sort all the Elements of the targeted array alphabetically.
	return [self sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSArray*)sortedAlphabeticArrayUsing:(NSString *)descriptor
{
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:descriptor ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

- (NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString {
    NSUInteger index = 0;
    for (NSString *object in self) {
        if ([object caseInsensitiveCompare:aString] == NSOrderedSame) {
            return index;
        }
        index++;
    }
    return NSNotFound;
} 

- (NSMutableArray*)removeObjectsContainingString:(NSString *)aString 
{
	NSMutableArray *newArray=[[[NSMutableArray alloc] init] autorelease];
	for (NSString *obj in self) 
	{
		if(![obj containsString:aString])
		{
			[newArray addObject:obj];
		}
		//[self removeObjectAtIndex:[self indexOfObject:obj]];
	}
	return newArray;
}

- (NSMutableArray*)removeObjectsWithoutString:(NSString *)aString 
{
	NSMutableArray *newArray=[[[NSMutableArray alloc] init] autorelease];
	for (NSString *obj in self) 
	{
		if([obj containsString:aString])
		{
			[newArray addObject:obj];
		}
		//[self removeObjectAtIndex:[self indexOfObject:obj]];
	}
	return newArray;
}

- (NSMutableArray*)removeObjectsStartsWithString:(NSString *)aString 
{
	NSMutableArray *newArray=[[[NSMutableArray alloc] init] autorelease];
	for (NSString *obj in self) 
	{
		obj=[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if(![obj hasPrefix:aString])
		{
			[newArray addObject:obj];
		}
		//[self removeObjectAtIndex:[self indexOfObject:obj]];
	}
	return newArray;
}

-(NSArray*)arrayOfValuesForKey:(NSString*)key
{
	//creates new array with objects for passed key in all the elements of targetted array
	NSMutableArray *newArray=[[[NSMutableArray alloc] init] autorelease];
	for (NSDictionary *obj in self) 
	{
		[newArray addObject:[obj objectForKey:key]];
	}
	return newArray;
}

@end

/*
 * NSObject provides default implementations of -hash (which returns the address of the instance, like(NSUInteger)self) 
 * and -isEqual: (which returns NO unless the addresses of the receiver and the parameter are identical). 
 * These methods are designed to be overridden as necessary, but the documentation makes it clear that you should provide both or neither. 
 * Further, if -isEqual: returnsYES for two objects, then the result of -hash for those objects must be the same.
 */
@implementation NSArray (Hash)

/*
 * Override isEqual method as required in order to match hash process check
 */
//- removing isEqual implementation in order to avoid issue related to #2497
//- need further investigation
/*
-(BOOL) isEqual:(id)object
{
	//- check if both objects are nil
	//- then if parameter object is an NSArray then compare hash with self hash
	return ((self == nil && object == nil) || ([object isKindOfClass:[NSArray class]] && [[self hash] isEqualToString:[(NSArray*)object hash]] ))
	? TRUE
	: FALSE;
	
}
*/

-(NSArray*)arrayOfValuesForKey:(NSString*)key
{
	NSMutableArray *newArray=[[[NSMutableArray alloc] init] autorelease];
	for (NSDictionary *obj in self)
	{
		[newArray addObject:[obj objectForKey:key]];
	}
	return newArray;
}

@end
#pragma mark -