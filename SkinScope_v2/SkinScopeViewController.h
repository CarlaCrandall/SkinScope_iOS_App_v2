//
//  SkinScopeViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface SkinScopeViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UITextField *email;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UIButton *login;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property RKObjectManager *objectManager;

-(void)checkAccountInfo;
-(void)configureRestKit;
-(IBAction)attemptLogin:(id)sender;
-(void)pushSearchVC;

@end
