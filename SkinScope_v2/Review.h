//
//  Review.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic,assign) int userID;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSString *skin_type;
@property (nonatomic,strong) NSString *review;


-(id)initWithUserID:(int)u_id user:(NSString *)r_user skin_type:(NSString *)r_skin_type review:(NSString *)r_review;
-(id)initWithReview:(NSString *)r_review;

@end
