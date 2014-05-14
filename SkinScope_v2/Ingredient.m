//
//  Ingredient.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize ingredientID, name, rating, function, benefits, negatives, com, irr, description;

-(id)initWithIngredientID:(int)i_id name:(NSString *)i_name rating:(NSString *)i_rating function:(NSString *)i_function benefits:(NSString *)i_benefits negatives:(NSString *)i_negatives com:(int)i_com irr:(int)i_irr description:(NSString *)i_desc{
    
    self = [super init];
    
    // set properties
    if(self){
        ingredientID = i_id;
        name = i_name;
        rating = i_rating;
        function = i_function;
        benefits = i_benefits;
        negatives = i_negatives;
        com = i_com;
        irr = i_irr;
        description = i_desc;
    }
    
    return self;
}

@end
