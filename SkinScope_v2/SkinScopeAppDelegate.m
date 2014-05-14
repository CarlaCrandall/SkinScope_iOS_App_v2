//
//  SkinScopeAppDelegate.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "SkinScopeAppDelegate.h"
#import <RestKit/RestKit.h>
#import "Product.h"
#import "Review.h"
#import "Ingredient.h"

@implementation SkinScopeAppDelegate

@synthesize objectManager, loginMapping, productSearchMapping, productReviewsMapping, loginDescriptor, productSearchDescriptor, productReviewsDescriptor, productIngredientsMapping, productIngredientsDescriptor;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://skinscope.info"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // Initialize RestKit
    objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    [self defineObjectMappings];
    [self defineResponseDesciptors];
    [self addResponseDescriptors];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark RestKit / API Call Functions


//all RestKit / API call object mappings are defined here
-(void)defineObjectMappings{
    
    //object mapping for login attempt
    loginMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    
    //object mapping for product search
    productSearchMapping = [RKObjectMapping mappingForClass:[Product class]];
    [productSearchMapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"productID",
                                                  @"upc": @"upc",
                                                  @"name": @"name",
                                                  @"brand": @"brand",
                                                  @"category": @"category",
                                                  @"rating": @"rating",
                                                  @"numIngredients": @"numIngredients",
                                                  @"numIrritants": @"numIrritants",
                                                  @"numComedogenics": @"numComedogenics",
                                                  @"numReviews": @"numReviews"
                                                  }];
    
    //object mapping for product reviews
    productReviewsMapping = [RKObjectMapping mappingForClass:[Review class]];
    [productReviewsMapping addAttributeMappingsFromDictionary:@{
                                                               @"review": @"review",
                                                               @"user.id": @"userID",
                                                               @"user.username": @"user",
                                                               @"user.skin_type": @"skin_type"
                                                               }];
    
    //object mapping for product ingredients
    productIngredientsMapping = [RKObjectMapping mappingForClass:[Ingredient class]];
    [productIngredientsMapping addAttributeMappingsFromDictionary:@{
                                                               @"id": @"ingredientID",
                                                               @"name": @"name",
                                                               @"rating": @"rating",
                                                               @"function": @"function",
                                                               @"benefits": @"benefits",
                                                               @"negatives": @"negatives",
                                                               @"com": @"com",
                                                               @"irr": @"irr",
                                                               @"description": @"description"
                                                               }];
}

//all RestKit / API call response descriptors are defined here
-(void)defineResponseDesciptors{
    
    //response descriptor for login attempt
    loginDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginMapping
                                                                   method:RKRequestMethodGET
                                                              pathPattern:@"/api/users/auth"
                                                                  keyPath:@""
                                                              statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    //response descriptor for product search
    productSearchDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productSearchMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/api/products"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    //response descriptor for product reviews
    productReviewsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productReviewsMapping
                                                                           method:RKRequestMethodGET
                                                                      pathPattern:@"/api/products/:id/reviews"
                                                                          keyPath:@""
                                                                      statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    //response descriptor for product reviews
    productIngredientsDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productIngredientsMapping
                                                                            method:RKRequestMethodGET
                                                                       pathPattern:@"/api/products/:id/ingredients"
                                                                           keyPath:@""
                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
}

-(void)addResponseDescriptors{
    [objectManager addResponseDescriptorsFromArray:@[loginDescriptor, productSearchDescriptor, productReviewsDescriptor, productIngredientsDescriptor]];
}

@end
