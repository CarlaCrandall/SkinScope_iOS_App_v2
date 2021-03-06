//
//  ProductSearchViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/9/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ZBarSDK.h"

@interface ProductSearchViewController : UIViewController <UIActionSheetDelegate, ZBarReaderDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic,strong) IBOutlet UIButton *addBtn;
@property (nonatomic,strong) IBOutlet UIButton *scanBtn;
@property (nonatomic,strong) IBOutlet UILabel *resultsLabel;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *filterButton;
@property (nonatomic,strong) IBOutlet UITableView *searchResults;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,strong) NSArray *products;
@property (nonatomic,strong) Product *product;
@property (nonatomic,strong) NSString *filterRating;
@property (nonatomic,strong) NSString *productUPC;

-(IBAction)showFilterModal;
-(IBAction)pushAddProductVC;
-(IBAction)showScanner;
-(void)searchForProducts;
-(void)searchByUPC;

@end
