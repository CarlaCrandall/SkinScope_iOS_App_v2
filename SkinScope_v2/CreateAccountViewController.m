//
//  CreateAccountViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/17/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <RestKit/RestKit.h>
#import "SSKeychain.h"
#import "User.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

@synthesize firstName, lastName, skinType, email, password, passwordConfirmation, submitBtn, scrollView, spinner, keyboardButtonView, activeField, skinTypeOptions;

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
    
    //show the navigation bar
    [self.navigationController.navigationBar setHidden:NO];
    
    //make navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //set nav bar title
    self.title = @"Create an Account";
    
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    
    //define skin type options
    skinTypeOptions = @[@"Select Skin Type",
                        @"Normal",
                        @"Oily",
                        @"Dry",
                        @"Sensitive",
                        @"Combination"];
    
    //setup delegate and datasource for dropdown
    skinType.pickerDelegate = self;
    skinType.pickerDataSource = self;
    
    
    //create toolbar for keyboard
    keyboardButtonView = [[UIToolbar alloc] init];
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
    firstName.inputAccessoryView = keyboardButtonView;
    lastName.inputAccessoryView = keyboardButtonView;
    skinType.inputAccessoryView = keyboardButtonView;
    email.inputAccessoryView = keyboardButtonView;
    password.inputAccessoryView = keyboardButtonView;
    passwordConfirmation.inputAccessoryView = keyboardButtonView;
    
    
    //set fonts
    [firstName setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [lastName setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [skinType setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [email setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [password setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [passwordConfirmation setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
    
    
    //set fonts for toolbar buttons
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [nextButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [prevButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    //change border color of text fields
    firstName.layer.borderColor=[[UIColor whiteColor]CGColor];
    firstName.layer.borderWidth= 1.0f;
    lastName.layer.borderColor=[[UIColor whiteColor]CGColor];
    lastName.layer.borderWidth= 1.0f;
    skinType.layer.borderColor=[[UIColor whiteColor]CGColor];
    skinType.layer.borderWidth= 1.0f;
    email.layer.borderColor=[[UIColor whiteColor]CGColor];
    email.layer.borderWidth= 1.0f;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    passwordConfirmation.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordConfirmation.layer.borderWidth= 1.0f;
    
    //add padding to left side of text fields
    firstName.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    lastName.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    skinType.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    email.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    password.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    passwordConfirmation.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    
    
    //set content size for scroll view
    //contentHeight = 300;
    [scrollView setContentSize:CGSizeMake(250, 303)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Text Field Functions


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
    
    //keep track of the active text field
    activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //dismiss the keyboard
    [textField resignFirstResponder];
    
    //unset the active text field
    activeField = nil;
}


//prevent user from typing in the skin type dropdown field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == skinType){
        return NO;
    }
    
    return YES;
}


//hide keyboard when user presses the "done" button
-(IBAction)doneClicked:(id)sender{
    [self.view endEditing:YES];
}


//move to next field when user presses the "next" button
-(IBAction)nextClicked:(id)sender{
    
    UIView *view = [self.view viewWithTag:activeField.tag + 1];
    
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
    
    UIView *view = [self.view viewWithTag:activeField.tag - 1];
    
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
    skinType.text = [skinTypeOptions objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return skinTypeOptions.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [skinTypeOptions objectAtIndex:row];
}



#pragma mark Keyboard Functions


//register for keyboard notifications
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


//scroll form up when keyboard is shown
-(void)keyboardWasShown:(NSNotification *)notification{
    
    //get keyboard size
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //setup animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //adjust the bottom content inset of scroll view
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 5, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    //animate
    [UIView commitAnimations];
}


//move form back down when keyboard is hidden
-(void)keyboardWasHidden:(NSNotification*)notification{
    
    //setup animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //adjust scroll view inset
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    //animate
    [UIView commitAnimations];
}



#pragma mark API Call Functions


-(IBAction)submitAccount:(id)sender{
    
    //start activity indicator
    [spinner startAnimating];
    
    
    //create post url
    NSString *createAccountURL = @"/api/users/create";
    
    
    //create query params
    NSDictionary *queryParams = @{@"first_name": firstName.text,
                                  @"last_name": lastName.text,
                                  @"skin_type": skinType.text,
                                  @"email": email.text,
                                  @"password": password.text,
                                  @"password_confirmation": passwordConfirmation.text};
    
    //make the call
    [[RKObjectManager sharedManager] postObject:nil path:createAccountURL parameters:queryParams
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                            
            //stop activity indicator
            [spinner stopAnimating];
            
            
            //save account information to keychain
            [SSKeychain setPassword:password.text forService:@"SkinScope.com" account:email.text];
            
            //setup user
            User *sharedUser = [User sharedUser];
            [sharedUser setUsername:email.text];
            [sharedUser setPassword:password.text];
                                            
                                            
            //loop through all uitextfields
            for (UIView *view in [scrollView subviews]) {
                if ([view isKindOfClass:[UITextField class]]) {
                                                    
                    //clear out all text fields
                    UITextField *textField = (UITextField *)view;
                    textField.text = @"";
                }
            }
            
            
            //display success message
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your account has been created. Click \"Okay\" to begin using the app." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [successAlert show];
            
            
            //go to product search view controller
            [self pushSearchVC];
                                            
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error){
                                            
            //get errors as JSON
            NSString *errors = [[error userInfo] objectForKey:NSLocalizedRecoverySuggestionErrorKey];
                                            
            //convert JSON to dictionary
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[errors dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
                                            
            //create error message
            NSMutableString *errorMsg = [NSMutableString string];
                                            
            //handles message for server errors
            if([JSON objectForKey:@"error"] != nil){
                [errorMsg appendFormat:@"%@", [JSON objectForKey:@"error"]];
            }
            //handles message for validation errors
            else{
                                                
                //loop through dictionary to build error message
                [errorMsg appendString:@"Your account was not created for the following reasons: "];
                for (NSString* key in [JSON allKeys]){
                    [errorMsg appendFormat:@"%@ ", [[JSON objectForKey:key] objectAtIndex:0]];
                }
            }
                                            
                                            
            //stop activity indicator
            [spinner stopAnimating];
            
            
            //display error message
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
     ];
}



#pragma mark Segue


//segue to the product search view controller
-(void)pushSearchVC{
    [self performSegueWithIdentifier:@"pushSearchVC-B" sender:self];
}

@end
