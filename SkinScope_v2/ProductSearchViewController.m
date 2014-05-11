//
//  ProductSearchViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/9/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "ProductSearchViewController.h"
#import <RestKit/RestKit.h>
#import "Product.h"

@interface ProductSearchViewController ()

@end

@implementation ProductSearchViewController

@synthesize mySearchBar, resultsLabel, scanBtn, searchResults, products, filterRating;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
            
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    //show the navigation bar
    [self.navigationController.navigationBar setHidden:NO];
    
    //make navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //hide back button - already logged in, no need to go back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //change appearance of search bar
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setLeftViewMode:UITextFieldViewModeNever];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    
    //custom clear button in search bar
    UIImage *imgClear = [UIImage imageNamed:@"clear.png"];
    [mySearchBar setImage:imgClear forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    //set scan button image
    UIImage *btnImage = [UIImage imageNamed:@"scan.png"];
    [scanBtn setImage:btnImage forState:UIControlStateNormal];
    
    //round the corners of scan button
    CALayer *btnLayer = [scanBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    
    //change font of title
    [resultsLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    
    //prevent table cell left indentation
    [searchResults setSeparatorInset:UIEdgeInsetsZero];
    
    //don't filter products by default
    filterRating = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark Search Bar Functions


//clear filter when starting a new search
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    filterRating = @"";
}


//search submitted - make api call
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    //dismiss the keyboard
    [searchBar resignFirstResponder];
    
    //search
    [self searchForProducts];
}


//tapping outside the search bar will dimiss the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mySearchBar resignFirstResponder];
}



#pragma mark Table View Functions


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return products.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    Product *product = [products objectAtIndex:indexPath.row];
    
    //set table cell image based on product rating
    if([[product rating] isEqualToString:@"Good"]){
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good.png"]];
    }
    else if([[product rating] isEqualToString:@"Average"]){
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"average.png"]];
    }
    else if([[product rating] isEqualToString:@"Poor"]){
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"poor.png"]];
    }
    else{
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unknown.png"]];
    }
    
    //set product name
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
    cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
    cell.textLabel.text = [product name];
    
    //set product brand
    cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:10];
    cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
    cell.detailTextLabel.text = [product brand];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}



#pragma mark Search Result Functions


//search for products
-(void)searchForProducts{
    
    //setup query parameters
    NSDictionary *queryParams;
    
    //if no rating is specified, don't filter results
    if([filterRating isEqualToString:@""]){
        queryParams = @{@"name" : mySearchBar.text, @"brand" : mySearchBar.text};
    }
    //filter results based on rating
    else{
        queryParams = @{@"name" : mySearchBar.text, @"brand" : mySearchBar.text, @"rating" : filterRating};
    }
    
    //make the call
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/products" parameters:queryParams
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
            products = mappingResult.array; //store results
            [searchResults reloadData]; //show the results
                                                  
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
            products = [NSArray array]; //empty array
            [searchResults reloadData]; //empty the table view
                                                  
            //no products found, show error message
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No products were found." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
     ];
}


//display action sheet modal with filter options
-(IBAction)showFilterModal{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Filter Results by Rating" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"All Results",
                            @"Good",
                            @"Average",
                            @"Poor",
                            @"Unknown",
                            nil];
    
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}


//filter results
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //set filter
    switch (buttonIndex) {
            
        //all results
        case 0:
            filterRating = @"";
            break;
                    
        //good
        case 1:
            filterRating = @"Good";
            break;
                    
        //average
        case 2:
            filterRating = @"Average";
            break;
                    
        //poor
        case 3:
            filterRating = @"Poor";
            break;
                    
        //unknown
        case 4:
            filterRating = @"Unknown";
            break;
                    
        //default
        default:
            filterRating = @"";
            break;
    }
    
    //search for products
    [self searchForProducts];
}


@end
