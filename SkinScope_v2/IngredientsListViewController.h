//
//  IngredientsListViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Ingredient.h"

@interface IngredientsListViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *ingredientsLabel;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *filterButton;
@property (nonatomic,strong) IBOutlet UITableView *ingredientsList;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,assign) int pageIndex;
@property (nonatomic,strong) NSString *filterRating;
@property (nonatomic,strong) Product *product;
@property (nonatomic,strong) NSArray *ingredients;
@property (nonatomic,strong) Ingredient *ingredient;


-(IBAction)showFilterModal;
-(void)getIngredients;

@end
