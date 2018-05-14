//
//  POCViewController.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCViewController.h"
#import "POCConstants.h"
#import "POCService.h"
@interface POCViewController ()
@property (nonatomic, strong) NSMutableArray *factsArray;
@property (nonatomic, strong) POCService *service;

@end

@implementation POCViewController

@synthesize factsArray;
@synthesize service;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"POC";
    self.factsArray = [[NSMutableArray alloc] init];
    service = [[POCService alloc] init];
    
    //Get Data
    [service getDataWithCompletionHandler:^(NSMutableArray *array, NSString *headerTitle, NSString *error){

        if (headerTitle) {
            self.title = headerTitle;
        }
        //Handle Error
        if (error) {

        }
        else{
            //Reload Table
            
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
