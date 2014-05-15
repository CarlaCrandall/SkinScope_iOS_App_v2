//
//  ReviewsViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "CustomReviewCell.h"

@interface ReviewsViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *reviewsLabel;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *composeButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *filterButton;
@property (nonatomic,strong) IBOutlet UITableView *reviewsList;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,assign) int pageIndex;
@property (nonatomic, strong) CustomReviewCell *prototypeCell;
@property (nonatomic,strong) NSString *filterSkinType;
@property (nonatomic,strong) Product *product;
@property (nonatomic,strong) NSArray *reviews;


-(IBAction)pushAddReviewVC;
-(IBAction)showFilterModal;
-(void)getReviews;

@end
