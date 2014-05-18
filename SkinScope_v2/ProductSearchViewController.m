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
#import "ProductViewController.h"


@interface ProductSearchViewController ()

@end

@implementation ProductSearchViewController

@synthesize mySearchBar, resultsLabel, addBtn, scanBtn, searchResults, products, product, filterRating, spinner;

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
    
    //set back button text and color for navigation controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setLeftViewMode:UITextFieldViewModeNever];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];    
    
    //custom clear button in search bar
    UIImage *imgClear = [UIImage imageNamed:@"clear.png"];
    [mySearchBar setImage:imgClear forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    //set scan button image
    UIImage *scanImage = [UIImage imageNamed:@"scan.png"];
    [scanBtn setImage:scanImage forState:UIControlStateNormal];
    
    //round the corners of scan button
    CALayer *btnLayer = [scanBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    
    //set add button image
    UIImage *addImage = [UIImage imageNamed:@"add.png"];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    
    //round the corners of add button
    CALayer *addLayer = [addBtn layer];
    [addLayer setMasksToBounds:YES];
    [addLayer setCornerRadius:3.0f];
    
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


#pragma mark Search Bar Functions


//clear filter and placeholder text when starting a new search
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    mySearchBar.text = @"";
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
    
    Product *rowProduct = [products objectAtIndex:indexPath.row];
    
    //set table cell image based on product rating
    if([[rowProduct rating] isEqualToString:@"Good"]){
        cell.imageView.image = [UIImage imageNamed:@"good.png"];
    }
    else if([[rowProduct rating] isEqualToString:@"Average"]){
        cell.imageView.image = [UIImage imageNamed:@"average.png"];
    }
    else if([[rowProduct rating] isEqualToString:@"Poor"]){
        cell.imageView.image = [UIImage imageNamed:@"poor.png"];
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"unknown.png"];
    }
    
    //set product name
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
    cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
    cell.textLabel.text = [rowProduct name];
    
    //set product brand
    cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:10];
    cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
    cell.detailTextLabel.text = [rowProduct brand];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // get product
    product = [products objectAtIndex:indexPath.row];
    
    //push next view controller
    [self pushProductVC];
}



#pragma mark Search Result Functions


//search for products
-(void)searchForProducts{
    
    //show activity indicator
    [spinner startAnimating];
    
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
            
            [spinner stopAnimating]; //hide activity indicator
            
            products = mappingResult.array; //store results
            [searchResults reloadData]; //show the results
                                                  
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            [spinner stopAnimating]; //hide activity indicator
                                                  
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
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"  Filter by Rating" delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"All Results",
                            @"Good",
                            @"Average",
                            @"Poor",
                            @"Unknown",
                            nil];
    
    //show action sheet
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}


//customize action sheet title and buttons
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    
    for (UIView *subview in actionSheet.subviews) {
        
        //customize buttons
        if ([subview isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)subview;
            
            //set color
            [button setTitleColor:[UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1] forState:UIControlStateNormal];
            
            //set font
            [button.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
            
            //set alignment and padding
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0.0, 25.0, 0.0, 0.0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)];
            
            //custom padding on cancel button since it does not have an image
            if([button.titleLabel.text isEqualToString:@"Cancel"]){
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
            }
                
            //add icons to action sheet buttons
            if([button.titleLabel.text isEqualToString:@"All Results"]){
                [button setImage:[UIImage imageNamed:@"allResults.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Good"]){
                [button setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Average"]){
                [button setImage:[UIImage imageNamed:@"average.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Poor"]){
                [button setImage:[UIImage imageNamed:@"poor.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Unknown"]){
                [button setImage:[UIImage imageNamed:@"unknown.png"] forState:UIControlStateNormal];
            }
        }
        //customize title
        else if ([subview isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *)subview;
            
            //set color
            [label setTextColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1]];
            
            //set font
            [label setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
            
            //set alignment
            [label setTextAlignment:NSTextAlignmentLeft];
        }
    }
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
    if(![mySearchBar.text isEqualToString:@""] && ![mySearchBar.text isEqualToString:@"Search"]){
        [self searchForProducts];
    }
    
}



#pragma mark Segue


//segue to the product search view controller
-(void)pushProductVC{
    [self performSegueWithIdentifier:@"pushProductVC" sender:self];
}

//segue to the product search view controller
-(IBAction)pushAddProductVC{
    [self performSegueWithIdentifier:@"pushAddProductVC" sender:self];
}


//pass product to next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushProductVC"]) {
        
        // Get destination view
        ProductViewController *productViewController = [segue destinationViewController];
        
        // Pass the product to destination view
        [productViewController setProduct:product];
    }
}


@end
