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

//set username
-(void)setUsername:(NSString *)u_name{
    username = u_name;
}

//set password
-(void)setPassword:(NSString *)u_pass{
    password = u_pass;
}


@end
