//
//  Product.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/8/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic,assign) int productID;
@property (nonatomic,strong) NSString *upc;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *brand;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *rating;
@property (nonatomic,assign) int numIngredients;
@property (nonatomic,assign) int numIrritants;
@property (nonatomic,assign) int numComedogenics;
@property (nonatomic,assign) int numReviews;

-(id)initWithID:(int)p_id upc:(NSString *)p_upc name:(NSString *)p_name brand:(NSString *)p_brand category:(NSString *)p_cat rating:(NSString *)p_rating;


@end
