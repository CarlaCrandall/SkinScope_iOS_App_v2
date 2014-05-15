//
//  AddReviewViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface AddReviewViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,strong) IBOutlet UILabel *writeReviewLabel;
@property (nonatomic,strong) IBOutlet UITextView *reviewText;
@property (nonatomic,strong) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) IBOutlet UIButton *clearBtn;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,strong) Product *product;

-(IBAction)clearReviewText;
-(IBAction)submitReview;

@end
