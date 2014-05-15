//
//  PageViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "PageViewController.h"
#import "ProductViewController.h"
#import "ReviewsViewController.h"
#import "IngredientsListViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

@synthesize myPageViewController, pageTitles, pageIDs, product;

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
    
    //set nav bar title
    self.title = product.name;
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    //set page titles and IDs for child view controllers
    pageTitles = @[@"Product Overview", @"Product Reviews", @"Product Ingredients"];
    pageIDs = @[@"ProductOverview", @"ProductReviews", @"ProductIngredients"];
    
    //create page view controller
    myPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    [myPageViewController setDataSource:self];
    
    //setup first child view controller
    ProductViewController *startingViewController = (ProductViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [myPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    //show the page view controller
    [self addChildViewController:myPageViewController];
    [self.view addSubview:myPageViewController.view];
    [myPageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Page View Controller Data Source


//get view previous view controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //get current page/index
    NSUInteger index = ((ProductViewController*) viewController).pageIndex;
    
    //if currently on first page, there is no previous page
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    //get previous page
    index--;
    
    //return previous view controller
    return [self viewControllerAtIndex:index];
}


//get next view controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //get current page/index
    NSUInteger index = ((ProductViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    //get next page/index
    index++;
    
    //if currently on last page, there is no next page
    if (index == [self.pageTitles count]) {
        return nil;
    }
    
    //return next view controller
    return [self viewControllerAtIndex:index];
}


//create next view controller
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    //if first page, create the product overview view controller
    if(index == 0){
        
        //create view controller
        ProductViewController *productViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductOverview"];
        
        //pass data
        productViewController.pageIndex = index;
        productViewController.product = product;
        
        return productViewController;
    }
    //if second page, create the product reviews view controller
    else if(index == 1){
        
        //create view controller
        ReviewsViewController *reviewsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductReviews"];
        
        //pass data
        reviewsViewController.pageIndex = index;
        reviewsViewController.product = product;
        
        return reviewsViewController;
    }
    //if third page, create the product ingredients view controller
    else if(index == 2){
        
        //create view controller
        IngredientsListViewController *ingredientsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductIngredients"];
        
        //pass data
        ingredientsViewController.pageIndex = index;
        ingredientsViewController.product = product;
        
        return ingredientsViewController;
    }
    
    return nil;
}



#pragma mark Page Indicator Functions


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}


- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
