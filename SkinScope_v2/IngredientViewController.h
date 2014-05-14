//
//  IngredientViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *ingredientLabel;
@property (nonatomic,strong) IBOutlet UILabel *irr;
@property (nonatomic,strong) IBOutlet UILabel *irrLabel;
@property (nonatomic,strong) IBOutlet UILabel *com;
@property (nonatomic,strong) IBOutlet UILabel *comLabel;
@property (nonatomic,strong) IBOutlet UILabel *rating;
@property (nonatomic,strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic,strong) IBOutlet UIImageView *ratingBkg;
@property (nonatomic,strong) IBOutlet UILabel *function;
@property (nonatomic,strong) IBOutlet UILabel *functionLabel;
@property (nonatomic,strong) IBOutlet UILabel *description;
@property (nonatomic,strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong) Ingredient *ingredient;

@end
