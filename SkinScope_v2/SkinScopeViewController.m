//
//  SkinScopeViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "SkinScopeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SkinScopeViewController ()

@end

@implementation SkinScopeViewController

@synthesize titleLabel, email, password, login, spinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //clear background allows background image to show through
    self.view.backgroundColor = [UIColor clearColor];
    
    //change font of title
    [titleLabel setFont:[UIFont fontWithName:@"Bree-Bold" size:50]];
    
    //change font of text fields
    UIFont *pn_reg = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    [email setFont:pn_reg];
    [password setFont:pn_reg];
    
    //change border color of text fields
    email.layer.borderColor=[[UIColor whiteColor]CGColor];
    email.layer.borderWidth= 1.0f;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    
    //add padding to left side of text fields
    email.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    password.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    
    //change font of button
    login.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
    
    //clear out previous text when user enters field
    email.clearsOnBeginEditing = YES;
    password.clearsOnBeginEditing = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Keyboard Related Functions


//handles navigating between text fields and dismissing the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.password) {
        [textField resignFirstResponder];
    }
    else if (textField == self.email) {
        [self.password becomeFirstResponder];
    }
    
    return YES;
}


//slide form up when the user begins editing
//prevents fields from getting stuck under the keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //setup animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //move form up
    email.frame = CGRectMake(email.frame.origin.x, (email.frame.origin.y - 100.0), email.frame.size.width, email.frame.size.height);
    password.frame = CGRectMake(password.frame.origin.x, (password.frame.origin.y - 100.0), password.frame.size.width, password.frame.size.height);
    login.frame = CGRectMake(login.frame.origin.x, (login.frame.origin.y - 100.0), login.frame.size.width, login.frame.size.height);
    
    [UIView commitAnimations];
}


//slide form down when user is finished editing
//prevents fields from getting stuck under the keyboard
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //setup animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //move form down
    email.frame = CGRectMake(email.frame.origin.x, (email.frame.origin.y + 100.0), email.frame.size.width, email.frame.size.height);
    password.frame = CGRectMake(password.frame.origin.x, (password.frame.origin.y + 100.0), password.frame.size.width, password.frame.size.height);
    login.frame = CGRectMake(login.frame.origin.x, (login.frame.origin.y + 100.0), login.frame.size.width, login.frame.size.height);
    
    [UIView commitAnimations];
}


//tapping outside the form will dimiss the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark Custom Functions


//attempt to login using supplied credentials
-(IBAction)attemptLogin:(id)sender{
    
    //dismiss the keyboard
    [self.view endEditing:YES];
    
    //show activity indicator
    [spinner startAnimating];
    
    
}



@end
