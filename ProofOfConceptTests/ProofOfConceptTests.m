//
//  ProofOfConceptTests.m
//  ProofOfConceptTests
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "POCConstants.h"
@interface ProofOfConceptTests : XCTestCase
@property (nonatomic, strong) NSOperationQueue *backgroundqueue;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURL *url;
@end

@implementation ProofOfConceptTests
@synthesize backgroundqueue;
@synthesize request;
@synthesize url;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!url) {
        url = [NSURL URLWithString:POCUrl];
    }
    
    if (!request) {
        request = [[NSMutableURLRequest alloc] initWithURL:url];
    }
    
    if (!backgroundqueue) {
        backgroundqueue = [[NSOperationQueue alloc] init];
    }
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    url = nil;
    request = nil;
    backgroundqueue = nil;
    [super tearDown];
}

- (void)testCallingUrlSucceed{
    
    NSString *description = @"Completion handler invoked";
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    __block NSInteger statusCode;
    __block NSError *error;
    [NSURLConnection sendAsynchronousRequest:request queue:backgroundqueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *errorIs){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        statusCode = httpResponse.statusCode;
        error = errorIs;
        [expectation fulfill];
        
    }];
    
    // Wait for the async request to complete
    [self waitForExpectationsWithTimeout:60 handler: nil];
    
    XCTAssertNil(error);
    XCTAssertEqual(statusCode, 200);
    
}
@end
