//
//  User.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/8/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *password;

//init
+(id)sharedUser;
-(id)initWithUsername:(NSString *)u_name password:(NSString *)u_pass;

//setters and getters
-(void)setUsername:(NSString *)u_name;
-(void)setPassword:(NSString *)u_pass;
-(NSString *)getUsername;
-(NSString *)getPassword;

@end
