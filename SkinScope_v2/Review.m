//
//  Review.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "Review.h"

@implementation Review

@synthesize userID, user, skin_type, review;

-(id)initWithUserID:(int)u_id user:(NSString *)r_user skin_type:(NSString *)r_skin_type review:(NSString *)r_review{
    self = [super init];
    
    // set properties
    if(self){
        userID = u_id;
        user = r_user;
        skin_type = r_skin_type;
        review = r_review;
    }
    
    return self;
}

-(id)initWithReview:(NSString *)r_review{
    self = [super init];
    
    // set properties
    if(self){
        review = r_review;
    }
    
    return self;
}

@end
