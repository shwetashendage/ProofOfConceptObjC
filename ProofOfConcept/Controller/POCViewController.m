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

//SDWebImage
#import <SDWebImage/UIImageView+WebCache.h>

@interface POCViewController (){
    UIRefreshControl *refreshControl;
}
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
    self.tableView.accessibilityIdentifier = POCTableViewAccessibilityID;
    
    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = [[UIRefreshControl alloc] init];
        [self.tableView.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
        
    } else {
        // Fallback on earlier versions
        refreshControl = [[UIRefreshControl alloc] init];
        [self.tableView addSubview:refreshControl];
        [refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    }
    
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
                [self showAlert];
            }
            else{
                self.factsArray = array;
                //Reload Table
                [self.tableView reloadData];
                
            }
        }];
    }
    
    
}
#pragma mark Refresh Control

- (void)pullToRefresh{
    //Get Data
    if ([internetConnection checkFornetConnection]) {
        [self showProgressView];
        [service getDataWithCompletionHandler:^(NSMutableArray *array, NSString *headerTitle, NSString *error){
            
            [self hideProgressView];
            
            if (@available(iOS 10.0, *)) {
                [self.tableView.refreshControl endRefreshing];
            } else {
                // Fallback on earlier versions
                [refreshControl endRefreshing];
            }
            if (headerTitle) {
                self.title = headerTitle;
            }
            //Handle Error
            if (error) {
                [self showAlert];
            }
            else{
                self.factsArray = array;
                //Reload Table
                [self.tableView reloadData];
                
            }
        }];
    }
}
- (void)showAlert{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@"Error occurred."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    [cell.activityIndicator startAnimating];
    [cell.profileImageView sd_setImageWithURL:[NSURL URLWithString:fact.imageHref] placeholderImage:[UIImage imageNamed:@"default-user-image"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [cell.activityIndicator stopAnimating];
        
    }];
    
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
