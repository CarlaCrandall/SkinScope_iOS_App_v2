//
//  Product.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/8/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize productID, upc, name, brand, category, rating;


-(id)initWithID:(int)p_id upc:(NSString *)p_upc name:(NSString *)p_name brand:(NSString *)p_brand category:(NSString *)p_cat rating:(NSString *)p_rating{
    
    self = [super init];
    
    // set properties
    if(self){
        productID = p_id;
        upc = p_upc;
        name = p_name;
        brand = p_brand;
        category = p_cat;
        rating = p_rating;
    }
    
    return self;
}

@end
