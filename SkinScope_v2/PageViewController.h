//
//  PageViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Product.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *myPageViewController;
@property (nonatomic,strong) NSArray *pageTitles;
@property (nonatomic,strong) Product *product;

@end
