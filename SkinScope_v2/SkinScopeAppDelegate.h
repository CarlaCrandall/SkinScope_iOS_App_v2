//
//  SkinScopeAppDelegate.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "User.h"

@interface SkinScopeAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic,strong) RKObjectManager *objectManager;

//RestKit Object Mappings
@property (nonatomic,strong) RKObjectMapping *loginMapping;
@property (nonatomic,strong) RKObjectMapping *productSearchMapping;


//RestKit Response Descriptors
@property (nonatomic,strong) RKResponseDescriptor *loginDescriptor;
@property (nonatomic,strong) RKResponseDescriptor *productSearchDescriptor;


-(void)defineObjectMappings;
-(void)defineResponseDesciptors;
-(void)addResponseDescriptors;

@end
