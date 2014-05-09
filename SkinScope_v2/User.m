//
//  User.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/8/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username, password;


//init user
-(id)initWithUsername:(NSString *)u_name password:(NSString *)u_pass{
    
    self = [super init];
    
    // set properties
    if(self){
        username = u_name;
        password = u_pass;
    }
    
    return self;
}


#pragma mark Singleton Methods

+ (id)sharedUser{
    static User *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[self alloc] init];
    });
    return sharedUser;
}

-(id)init{
    if (self = [super init]) {
        username = @"DefaultUsername";
        password = @"DefaultPassword";
    }
    return self;
}


#pragma mark Getters and Setters

-(void)setUsername:(NSString *)u_name{
    username = u_name;
}

-(void)setPassword:(NSString *)u_pass{
    password = u_pass;
}

-(NSString *)getUsername{
    return username;
}

-(NSString *)getPassword{
    return password;
}


@end
