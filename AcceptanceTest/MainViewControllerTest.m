//
//  MainViewControllerTest.m
//  PicJoin
//
//  Created by Duong Nguyen on 9/1/15.
//  Copyright (c) 2015 Atmarkcafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KIF/KIF.h>

#define tester KIFActorWithClass(KIFUITestActor)

@interface MainViewControllerTest : KIFTestCase

@end

@implementation MainViewControllerTest



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testSelectShare
{
    
    [tester waitForTappableViewWithAccessibilityLabel:@"selectAndHideView"];
    [tester tapViewWithAccessibilityLabel:@"selectAndHideView"];
}
@end
