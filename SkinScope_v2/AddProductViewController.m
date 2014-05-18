//
//  AddProductViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "AddProductViewController.h"
#import <RestKit/RestKit.h>
#import "User.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

@synthesize name, brand, categoryDropdown, upc, categoryOptions, firstIngredient, addIngredientBtn, submitBtn, scrollView, activeField, previousIngredient, keyboardButtonView, contentHeight, spinner;

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
    name.inputAccessoryView = keyboardButtonView;
    brand.inputAccessoryView = keyboardButtonView;
    categoryDropdown.inputAccessoryView = keyboardButtonView;
    upc.inputAccessoryView = keyboardButtonView;
    firstIngredient.inputAccessoryView = keyboardButtonView;
    
    
    //set fonts
    [name setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [brand setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [categoryDropdown setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [upc setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    [firstIngredient setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:16]];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
    
    
    //set fonts for toolbar buttons
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [nextButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [prevButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Bold" size:16], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    //change border color of text fields
    name.layer.borderColor=[[UIColor whiteColor]CGColor];
    name.layer.borderWidth= 1.0f;
    brand.layer.borderColor=[[UIColor whiteColor]CGColor];
    brand.layer.borderWidth= 1.0f;
    categoryDropdown.layer.borderColor=[[UIColor whiteColor]CGColor];
    categoryDropdown.layer.borderWidth= 1.0f;
    upc.layer.borderColor=[[UIColor whiteColor]CGColor];
    upc.layer.borderWidth= 1.0f;
    firstIngredient.layer.borderColor=[[UIColor whiteColor]CGColor];
    firstIngredient.layer.borderWidth= 1.0f;
    
    //add padding to left side of text fields
    name.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    brand.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    categoryDropdown.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    upc.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    firstIngredient.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    
    
    //set content size for scroll view
    contentHeight = 300;
    [scrollView setContentSize:CGSizeMake(250, contentHeight)];
    
    
    //set add ingredient button image
    UIImage *addImage = [UIImage imageNamed:@"add.png"];
    [addIngredientBtn setImage:addImage forState:UIControlStateNormal];
    
    
    //set previous ingredient field - used to dynamically add more ingredient fields
    previousIngredient = firstIngredient;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
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


//prevent user from typing in the category dropdown field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == categoryDropdown){
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


//dynamically create text field for next ingredient
-(IBAction)addTextField:(id)sender{

    //create frame for new text field
    CGRect nextIngredientFrame = CGRectMake(previousIngredient.frame.origin.x,
                                           previousIngredient.frame.origin.y + 38,
                                           previousIngredient.frame.size.width,
                                           previousIngredient.frame.size.height);
    
    //init new text field
    UITextField *nextIngredient = [[UITextField alloc] initWithFrame:nextIngredientFrame];
    
    //settings for new text field
    nextIngredient.delegate = self;
    nextIngredient.tag = previousIngredient.tag + 1;
    nextIngredient.placeholder = @"Ingredient";
    nextIngredient.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    nextIngredient.autocorrectionType = UITextAutocorrectionTypeNo;
    nextIngredient.keyboardType = UIKeyboardTypeDefault;
    nextIngredient.returnKeyType = UIReturnKeyNext;
    nextIngredient.backgroundColor = [UIColor whiteColor];
    nextIngredient.borderStyle = UITextBorderStyleLine;
    nextIngredient.layer.borderColor=[[UIColor whiteColor]CGColor];
    nextIngredient.layer.borderWidth= 1.0f;
    nextIngredient.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    
    
    //add toolbar to keyboard
    nextIngredient.inputAccessoryView = keyboardButtonView;
    
    //add new text field to scroll view
    [scrollView addSubview:nextIngredient];
    
    
    //move add ingredient button down
    CGRect addButtonFrame = CGRectMake(addIngredientBtn.frame.origin.x,
                                       addIngredientBtn.frame.origin.y + 38,
                                       addIngredientBtn.frame.size.width,
                                       addIngredientBtn.frame.size.height);
    [addIngredientBtn setFrame:addButtonFrame];
    
    
    //change width of previous ingredient field
    CGRect prevIngredientFrame = CGRectMake(previousIngredient.frame.origin.x,
                              previousIngredient.frame.origin.y,
                              250,
                              previousIngredient.frame.size.height);
    [previousIngredient setFrame:prevIngredientFrame];

    
    //move submit button down
    CGRect submitButtonFrame = CGRectMake(submitBtn.frame.origin.x,
                                          submitBtn.frame.origin.y + 38,
                                          submitBtn.frame.size.width,
                                          submitBtn.frame.size.height);
    [submitBtn setFrame:submitButtonFrame];
    
    
    //set previous ingredient field to new field - for the next time we want to add a new field
    previousIngredient = nextIngredient;
    
    
    //activate new text field
    [nextIngredient becomeFirstResponder];
    
    
    //recalculate content size of scroll view
    contentHeight += 38;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, contentHeight);
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



#pragma mark API Call Functions


-(IBAction)submitProduct:(id)sender{
    
    //start activity indicator
    [spinner startAnimating];
    
    //create post url
    NSString *addProductURL = @"/api/products/create";
    
    
    //create query params
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setObject:name.text forKey:@"name"];
    [queryParams setObject:brand.text forKey:@"brand"];
    [queryParams setObject:categoryDropdown.text forKey:@"category"];
    
    //add upc to params, if available
    if([upc.text length] > 0){
        [queryParams setObject:upc.text forKey:@"upc"];
    }
    
    
    //array to hold ingredients
    NSMutableArray *ingredients = [[NSMutableArray alloc] init];
    
    //loop through uitextfields to get ingredients
    for (UIView *view in [scrollView subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            
            UITextField *textField = (UITextField *)view;
            
            //if text field is an ingredient field...
            if(textField.tag >= 5 && [textField.text length] > 0){
                
                //add to ingredients array
                [ingredients addObject:textField.text];
            }
        }
    }
    
    //add ingredients to query params
    [queryParams setObject:ingredients forKey:@"ingredients"];
    
    
    //get user credentials
    User *sharedUser = [User sharedUser];
    NSString *username = [sharedUser getUsername];
    NSString *password = [sharedUser getPassword];

    
    //setup header for authentication
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:username password:password];
    
    
    //make the call
    [[RKObjectManager sharedManager] postObject:nil path:addProductURL parameters:queryParams
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                            
            //stop activity indicator
            [spinner stopAnimating];
            
            
            //loop through all uitextfields
            for (UIView *view in [scrollView subviews]) {
                if ([view isKindOfClass:[UITextField class]]) {
                    
                    //clear out all text fields
                    UITextField *textField = (UITextField *)view;
                    textField.text = @"";
                    
                    //remove extra ingredient fields
                    if(textField.tag > 5){
                        [textField removeFromSuperview];
                    }
                }
            }
            
            
            //change width of original ingredient field
            CGRect firstIngredientFrame = CGRectMake(firstIngredient.frame.origin.x,
                                                    firstIngredient.frame.origin.y,
                                                    212,
                                                    firstIngredient.frame.size.height);
            [firstIngredient setFrame:firstIngredientFrame];
            
            
            //move add ingredient button back up
            CGRect addButtonFrame = CGRectMake(addIngredientBtn.frame.origin.x,
                                               185,
                                               addIngredientBtn.frame.size.width,
                                               addIngredientBtn.frame.size.height);
            [addIngredientBtn setFrame:addButtonFrame];
            
            
            //move submit button back up
            CGRect submitButtonFrame = CGRectMake(submitBtn.frame.origin.x,
                                                  228,
                                                  submitBtn.frame.size.width,
                                                  submitBtn.frame.size.height);
            [submitBtn setFrame:submitButtonFrame];

            
            //recalculate content size of scroll view
            contentHeight = 266;
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, contentHeight);
            
            
            //display success message
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your product has been submitted." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [successAlert show];
                                            
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error){
            
            //get errors as JSON
            NSString *errors = [[error userInfo] objectForKey:NSLocalizedRecoverySuggestionErrorKey];
            
            //convert JSON to dictionary
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [errors dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options: NSJSONReadingMutableContainers
                                                                   error: nil];
            
            //create error message
            NSMutableString *errorMsg = [NSMutableString string];
            
            //handles message for server errors
            if([JSON objectForKey:@"error"] != nil){
                [errorMsg appendFormat:@"%@", [JSON objectForKey:@"error"]];
            }
            //handles message for validation errors
            else{
                
                //loop through dictionary to build error message
                [errorMsg appendString:@"Your product was not submitted for the following reasons: "];
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


@end
