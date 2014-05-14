//
//  Ingredient.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property (nonatomic,assign) int ingredientID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *rating;
@property (nonatomic,strong) NSString *function;
@property (nonatomic,strong) NSString *benefits;
@property (nonatomic,strong) NSString *negatives;
@property (nonatomic,assign) int com;
@property (nonatomic,assign) int irr;
@property (nonatomic,strong) NSString *description;

-(id)initWithIngredientID:(int)i_id name:(NSString *)i_name rating:(NSString *)i_rating function:(NSString *)i_function benefits:(NSString *)i_benefits negatives:(NSString *)i_negatives com:(int)i_com irr:(int)i_int description:(NSString *)i_desc;

@end
