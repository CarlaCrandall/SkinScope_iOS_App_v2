//
//  IngredientViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "IngredientViewController.h"

@interface IngredientViewController ()

@end

@implementation IngredientViewController

@synthesize ingredient, ingredientLabel, irr, irrLabel, com, comLabel, rating, ratingLabel, ratingBkg, function, functionLabel, description, descriptionLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [description sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set nav bar title
    self.title = ingredient.name;
    
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    
    //change font of labels
    [ingredientLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    [irr setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [irrLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:12]];
    [com setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [comLabel setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:12]];
    [rating setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:16]];
    [ratingLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [function setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:12]];
    [functionLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    [description setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:12]];
    [descriptionLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:12]];
    
    
    //set text of rating
    rating.text = [ingredient.rating uppercaseString];
    
    
    //if irritancy rating is -1, set value to unknown
    if(ingredient.irr == -1){
        irr.text = @"?/5";
    }
    else{
        irr.text = [NSString stringWithFormat:@"%i/5", ingredient.irr];
    }
    
    
    //if comedogenicity rating is -1, set value to unknown
    if(ingredient.com == -1){
        com.text = @"?/5";
    }
    else{
        com.text = [NSString stringWithFormat:@"%i/5", ingredient.com];
    }
    
    
    //if function is null set text to unknown
    if([ingredient.function length] == 0){
        function.text = @"Unknown";
    }
    else{
        function.text = ingredient.function;
    }
    
    
    //if description is null set text to unknown
    if([ingredient.description length] == 0){
        description.text = @"Unknown";
    }
    else{
        //set text
        description.text = ingredient.description;
        
        //figure out height of description label
        CGSize maximumLabelSize = CGSizeMake(170, FLT_MAX);
        CGSize expectedLabelSize = [description.text sizeWithFont:description.font constrainedToSize:maximumLabelSize lineBreakMode:description.lineBreakMode];
        
        //resize description label
        CGRect newFrame = description.frame;
        newFrame.size.height = expectedLabelSize.height;
        description.frame = newFrame;
    }
    
    
    //set rating image bkg
    if([ingredient.rating isEqualToString:@"Good"]){
        ratingBkg.image = [UIImage imageNamed:@"goodBkg.png"];
    }
    else if([ingredient.rating isEqualToString:@"Average"]){
        ratingBkg.image = [UIImage imageNamed:@"averageBkg.png"];
    }
    else if([ingredient.rating isEqualToString:@"Poor"]){
        ratingBkg.image = [UIImage imageNamed:@"poorBkg.png"];
    }
    else if([ingredient.rating isEqualToString:@"Unknown"]){
        ratingBkg.image = [UIImage imageNamed:@"unknownBkg.png"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
