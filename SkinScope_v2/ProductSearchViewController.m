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

@synthesize mySearchBar, resultsLabel, scanBtn, products, objectManager;

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
    
    //setup RestKit object for api call(s)
    [self configureRestKit];
    
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
    
    //set scan button image
    UIImage *btnImage = [UIImage imageNamed:@"scan.png"];
    [scanBtn setImage:btnImage forState:UIControlStateNormal];
    
    //change font of title
    [resultsLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
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



#pragma mark Search Bar Methods


//search submitted
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"User searched for %@", searchBar.text);
    
    //dismiss the keyboard
    [searchBar resignFirstResponder];
    
    [self loadProducts];
}


//tapping outside the form will dimiss the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mySearchBar resignFirstResponder];
}


#pragma mark API Call Functions

//setup RestKit object for api call(s)
-(void)configureRestKit{
    
    //initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://skinscope.info"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    //initialize RestKit
    objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    //map results to product model
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[Product class]];
    [productMapping addAttributeMappingsFromArray:@[@"name"]];
    
    //create response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping method:RKRequestMethodGET pathPattern:@"/api/products" keyPath:@"" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
}


- (void)loadProducts{
    
    NSDictionary *queryParams = @{@"rating" : @"Good"};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/products"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  products = mappingResult.array;
                                                  NSLog(@"%@", products);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}





@end
