//
//  ProductViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "ProductViewController.h"
#import "Product.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

@synthesize overviewLabel, productName, brandName, rating, ratingLabel, ratingBkg, numIngredients, ingredientsLabel, numIrritants, irritantsLabel, numComedogenics, comedogenicsLabel, product;

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
    
    //clear background allows background image of page view controller to show through
    self.view.backgroundColor = [UIColor clearColor];
    
    //change font of labels
    [overviewLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    [productName setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:22]];
    [brandName setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
    [rating setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [ratingLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [numIngredients setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [ingredientsLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [numIrritants setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [irritantsLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [numComedogenics setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [comedogenicsLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    
    //set text of labels
    productName.text = product.name;
    brandName.text = product.brand;
    rating.text = [product.rating uppercaseString];
    numIngredients.text = [NSString stringWithFormat:@"%i", product.numIngredients];
    numIrritants.text = [NSString stringWithFormat:@"%i", product.numIrritants];
    numComedogenics.text = [NSString stringWithFormat:@"%i", product.numComedogenics];
    
    //set rating image bkg
    if([product.rating isEqualToString:@"Good"]){
        ratingBkg.image = [UIImage imageNamed:@"goodBkg.png"];
    }
    else if([product.rating isEqualToString:@"Average"]){
        ratingBkg.image = [UIImage imageNamed:@"averageBkg.png"];
    }
    else if([product.rating isEqualToString:@"Poor"]){
        ratingBkg.image = [UIImage imageNamed:@"poorBkg.png"];
    }
    else if([product.rating isEqualToString:@"Unknown"]){
        ratingBkg.image = [UIImage imageNamed:@"unknownBkg.png"];
    }
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
