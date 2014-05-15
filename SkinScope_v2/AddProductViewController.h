//
//  AddProductViewController.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dropdown.h"

@interface AddProductViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UITextField *name;
@property (nonatomic,strong) IBOutlet UITextField *brand;
@property (nonatomic,strong) IBOutlet Dropdown *categoryDropdown;
@property (nonatomic,strong) IBOutlet UITextField *upc;

@property (nonatomic,strong) NSArray *categoryOptions;
@property (nonatomic,assign) int currentField;

-(IBAction)doneClicked:(id)sender;
-(IBAction)nextClicked:(id)sender;
-(IBAction)prevClicked:(id)sender;

@end
