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

//Progress View
#import "MBProgressHUD.h"

//Internet
#import "POCInterNetConnectionService.h"

@interface POCViewController ()
@property (nonatomic, strong) NSMutableArray *factsArray;
@property (nonatomic, strong) POCService *service;
@property (nonatomic, strong) POCInterNetConnectionService *internetConnection;


@end

@implementation POCViewController

@synthesize factsArray;
@synthesize service;
@synthesize internetConnection;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"POC";
    self.factsArray = [[NSMutableArray alloc] init];
    service = [[POCService alloc] init];
    internetConnection = [[POCInterNetConnectionService alloc] init];
    
    //Get Data
    if ([internetConnection checkFornetConnection]) {
        [self showProgressView];
        [service getDataWithCompletionHandler:^(NSMutableArray *array, NSString *headerTitle, NSString *error){
            
            [self hideProgressView];
            
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
    
    
}

#pragma mark MBProgressHUD

- (void)showProgressView{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

- (void)hideProgressView{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
