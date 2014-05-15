//
//  AddProductViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

@synthesize name, brand, categoryDropdown, upc, categoryOptions, currentField, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //set nav bar title
    self.title = @"Add a Product";
    
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    
    //define category options
    categoryOptions = @[@"Select Category",
                        @"Cleanser",
                        @"Toner",
                        @"Makeup Remover",
                        @"Exfoliant",
                        @"Moisturizer",
                        @"Sunscreen",
                        @"Serum",
                        @"Mask",
                        @"Eye Care",
                        @"Lip Care",
                        @"Body Care"];
    
    //setup delegate and datasource for dropdown
    categoryDropdown.pickerDelegate = self;
    categoryDropdown.pickerDataSource = self;
    
    
    //create toolbar for keyboard
    UIToolbar* keyboardButtonView = [[UIToolbar alloc] init];
    keyboardButtonView.barStyle = UIBarStyleBlackTranslucent;
    keyboardButtonView.tintColor = [UIColor whiteColor];
    [keyboardButtonView sizeToFit];
    
    //create buttons for keyboard
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleBordered target:self
                                                                   action:@selector(doneClicked:)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(nextClicked:)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(prevClicked:)];
    
    //create flex space for toolbar
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //add toolbar to keyboard
    [keyboardButtonView setItems:[NSArray arrayWithObjects:prevButton, nextButton, flex, doneButton, nil]];
    name.inputAccessoryView = keyboardButtonView;
    brand.inputAccessoryView = keyboardButtonView;
    categoryDropdown.inputAccessoryView = keyboardButtonView;
    upc.inputAccessoryView = keyboardButtonView;
    
    
    //set fonts
    [name setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [brand setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [categoryDropdown setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [upc setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [nextButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [prevButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
}


- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}



#pragma mark Text Field / Keybord Related Functions


//handles navigating between text fields and dismissing the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UIView *view = [self.view viewWithTag:textField.tag + 1];
    
    if(!view){
        [textField resignFirstResponder];
    }
    else{
        [view becomeFirstResponder];
    }
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //keep track of current text field
    currentField = textField.tag;
    

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //dismiss the keyboard
    [textField resignFirstResponder];
    

}


//tapping outside the form will dimiss the keyboard/pickerview
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//hide keyboard when user presses the "done" button
-(IBAction)doneClicked:(id)sender{
    [self.view endEditing:YES];
}


//move to next field when user presses the "next" button
-(IBAction)nextClicked:(id)sender{
    
    UIView *view = [self.view viewWithTag:currentField + 1];
    
    //if no more text fields, end editing
    if(!view){
        [self.view endEditing:YES];
    }
    //move to next text field
    else{
        [view becomeFirstResponder];
    }
}


//move to previous when user presses the "prev" button
-(IBAction)prevClicked:(id)sender{
    
    UIView *view = [self.view viewWithTag:currentField - 1];
    
    //if no more text fields, end editing
    if(view.tag == 0){
        [self.view endEditing:YES];
    }
    //move to previous text field
    else{
        [view becomeFirstResponder];
    }
}





#pragma mark Picker View Functions


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    categoryDropdown.text = [categoryOptions objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return categoryOptions.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [categoryOptions objectAtIndex:row];
}



@end
