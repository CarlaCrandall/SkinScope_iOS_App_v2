//
//  ProductViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *overviewLabel;
@property (nonatomic,strong) IBOutlet UILabel *productName;
@property (nonatomic,strong) IBOutlet UILabel *brandName;
@property (nonatomic,strong) IBOutlet UILabel *rating;
@property (nonatomic,strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic,strong) IBOutlet UIImageView *ratingBkg;
@property (nonatomic,strong) IBOutlet UILabel *numIngredients;
@property (nonatomic,strong) IBOutlet UILabel *ingredientsLabel;
@property (nonatomic,strong) IBOutlet UILabel *numIrritants;
@property (nonatomic,strong) IBOutlet UILabel *irritantsLabel;
@property (nonatomic,strong) IBOutlet UILabel *numComedogenics;
@property (nonatomic,strong) IBOutlet UILabel *comedogenicsLabel;

@property (nonatomic,assign) int pageIndex;
@property (nonatomic,strong) Product *product;

@end
