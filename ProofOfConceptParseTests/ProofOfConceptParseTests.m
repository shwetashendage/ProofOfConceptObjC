//
//  ProofOfConceptParseTests.m
//  ProofOfConceptParseTests
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "POCService.h"

@interface ProofOfConceptParseTests : XCTestCase
@property (nonatomic, strong) POCService *service;
@end

@implementation ProofOfConceptParseTests
@synthesize service;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    service = [[POCService alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    service = nil;
    [super tearDown];
}

- (void)testDataParsingSuccessful{
    
    NSString *description = @"Status code: 200";
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    //Get Data
    [service getDataWithCompletionHandler:^(NSMutableArray *array, NSString *headerTitle, NSString *error){
        
        //Handle Error
        if (error) {
            
        }
        else{
            //Reload Table
            [expectation fulfill];
        }
        
    }];
    
    // Wait for the async request to complete
    [self waitForExpectationsWithTimeout:60 handler: nil];
    
    XCTAssertGreaterThan(service.factsArray.count, 0, "No Elements");
    
}

@end
