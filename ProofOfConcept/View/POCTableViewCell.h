//
//  POCTableViewCell.h
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface POCTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *description;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
