//
//  POCTableViewCell.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCTableViewCell.h"

@implementation POCTableViewCell
@synthesize title;
@synthesize description;
@synthesize profileImageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.title = [[UILabel alloc] init];
        self.title.textColor = [UIColor darkGrayColor];
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.title];
        
        self.description = [[UILabel alloc] init];
        self.description.textColor = [UIColor lightGrayColor];
        self.description.numberOfLines = 0;
        self.description.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.description];
        
        self.profileImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.profileImageView];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
        
        [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(padding.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(padding.left);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-padding.bottom);
            make.width.height.mas_equalTo(100);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.profileImageView.mas_top);
            make.left.equalTo(self.profileImageView.mas_right).with.offset(padding.right);
            make.right.equalTo(self.contentView.mas_right).with.offset(-padding.right);

        }];
        
        [self.description mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).with.offset(padding.bottom);
            make.left.equalTo(self.profileImageView.mas_right).with.offset(padding.right);
            make.right.equalTo(self.contentView.mas_right).with.offset(-padding.right);
            make.bottom.mas_lessThanOrEqualTo(-padding.bottom);
            
        }];
        
        
    }
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
