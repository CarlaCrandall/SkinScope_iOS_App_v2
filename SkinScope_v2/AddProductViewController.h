//
//  AddProductViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dropdown.h"

@interface AddProductViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UITextField *name;
@property (nonatomic,strong) IBOutlet UITextField *brand;
@property (nonatomic,strong) IBOutlet Dropdown *categoryDropdown;
@property (nonatomic,strong) IBOutlet UITextField *upc;
@property (nonatomic,strong) IBOutlet UITextField *firstIngredient;
@property (nonatomic,strong) IBOutlet UIButton *addIngredientBtn;
@property (nonatomic,strong) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic,strong) UIToolbar *keyboardButtonView;
@property (nonatomic,strong) UITextField *activeField;
@property (nonatomic,strong) UITextField *previousIngredient;
@property (nonatomic,strong) NSArray *categoryOptions;
@property (nonatomic,assign) int contentHeight;

-(IBAction)doneClicked:(id)sender;
-(IBAction)nextClicked:(id)sender;
-(IBAction)prevClicked:(id)sender;
-(IBAction)addTextField:(id)sender;
-(IBAction)submitProduct:(id)sender;

@end
