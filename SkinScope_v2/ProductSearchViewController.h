//
//  ProductSearchViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/9/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSearchViewController : UIViewController

@property (nonatomic,strong) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic,strong) IBOutlet UIButton *scanBtn;
@property (nonatomic,strong) IBOutlet UILabel *resultsLabel;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *filterButton;
@property (nonatomic,strong) IBOutlet UITableView *searchResults;

@property (nonatomic,strong) NSArray *products;

@end
