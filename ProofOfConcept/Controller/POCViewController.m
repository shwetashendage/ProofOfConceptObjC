//
//  POCViewController.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCViewController.h"
#import "POCConstants.h"
@interface POCViewController ()
@property (nonatomic, strong) NSOperationQueue *backgroundqueue;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURL *url;
@end

@implementation POCViewController
@synthesize backgroundqueue;
@synthesize request;
@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"POC";
    
    //Get Data
    [self getData];
    
}

- (void)getData{
    
    if (!url) {
        url = [NSURL URLWithString:POCUrl];
    }
    
    if (!request) {
        request = [[NSMutableURLRequest alloc] initWithURL:url];
    }
    
    if (!backgroundqueue) {
        backgroundqueue = [[NSOperationQueue alloc] init];
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:backgroundqueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error != nil || data.length == 0) {
            NSLog(@"%@",error);
        }
        else if (httpResponse.statusCode == 200 && data.length > 0){
            NSLog(@"%@",data);
        }
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
