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
#import "POCTableViewCell.h"
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
    
    //Table View
    [self.tableView registerClass:[POCTableViewCell self] forCellReuseIdentifier:POCCellID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
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
                self.factsArray = array;
                //Reload Table
                [self.tableView reloadData];
                
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

#pragma mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.factsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:POCCellID forIndexPath:indexPath];
    POCFacts *fact = [self.factsArray objectAtIndex:indexPath.row];
    cell.title.text = fact.title;
    cell.description.text = fact.descriptionString;
    cell.profileImageView.image = [UIImage imageNamed:@"default-user-image"];
    
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
