//
//  SkinScopeViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkinScopeViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UITextField *email;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UIButton *login;
@property (nonatomic,strong) IBOutlet UIButton *createAccount;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

-(IBAction)attemptLogin:(id)sender;

-(void)checkAccountInfo;
-(void)pushSearchVC;
-(IBAction)pushCreateAccountVC:(id)sender;

@end
