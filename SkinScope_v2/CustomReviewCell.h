//
//  CustomReviewCell.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomReviewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *username;
@property (nonatomic,strong) IBOutlet UILabel *skinTypeLabel;
@property (nonatomic,strong) IBOutlet UILabel *skinType;
@property (nonatomic,strong) IBOutlet UILabel *review;

@end
