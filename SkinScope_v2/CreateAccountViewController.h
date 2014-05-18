//
//  CreateAccountViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/17/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dropdown.h"

@interface CreateAccountViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextField *firstName;
@property (nonatomic,strong) IBOutlet UITextField *lastName;
@property (nonatomic,strong) IBOutlet Dropdown *skinType;
@property (nonatomic,strong) IBOutlet UITextField *email;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UITextField *passwordConfirmation;
@property (nonatomic,strong) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,strong) UIToolbar *keyboardButtonView;
@property (nonatomic,strong) UITextField *activeField;
@property (nonatomic,strong) NSArray *skinTypeOptions;

-(IBAction)doneClicked:(id)sender;
-(IBAction)nextClicked:(id)sender;
-(IBAction)prevClicked:(id)sender;
-(IBAction)submitAccount:(id)sender;

@end
