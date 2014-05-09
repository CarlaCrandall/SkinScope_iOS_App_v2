//
//  ProductSearchViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/9/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "ProductSearchViewController.h"

@interface ProductSearchViewController ()

@end

@implementation ProductSearchViewController

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
    
    //show navigation bar
    [self.navigationController setNavigationBarHidden:NO];
    
    //make navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //hide back button - already logged in, no need to go back
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //clear background allows background image to show through
    self.view.backgroundColor = [UIColor clearColor];
    
    //change font of title
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

@end
