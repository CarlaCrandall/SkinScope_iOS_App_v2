//
//  SkinScopeViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/7/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "SkinScopeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>
#import "SSKeychain.h"
#import "User.h"

@interface SkinScopeViewController ()

@end

@implementation SkinScopeViewController

@synthesize titleLabel, email, password, login, spinner, objectManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //check to see if account info is in keychain
    [self checkAccountInfo];
    
    //setup RestKit object for api call(s)
    [self configureRestKit];
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];

    //hide the navigation bar
    [self.navigationController.navigationBar setHidden:YES];
    
    //change font of navigation bar title
    [self.navigationController.navigationBar setTitleTextAttributes:
      [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], NSForegroundColorAttributeName,
        [UIFont fontWithName:@"Bree-Bold" size:18.0], NSFontAttributeName, nil]];
    
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



#pragma mark API Call Functions


//check to see if account information has been saved to keychain
-(void)checkAccountInfo{
    
    //get all accounts (if any)
    NSArray *accounts = [SSKeychain accountsForService:@"SkinScope.com"];
    
    //account info exists, login automatically
    if([accounts count] == 1){
        
        //get username & password from keychain
        NSString *username = [[accounts objectAtIndex:0] objectForKey:@"acct"];
        NSString *pass = [SSKeychain passwordForService:@"SkinScope.com" account:username];
        
        //[SSKeychain deletePasswordForService:@"SkinScope.com" account:username];
        
        //setup user
        User *sharedUser = [User sharedUser];
        [sharedUser setUsername:username];
        [sharedUser setPassword:pass];
        
        [self pushSearchVC];
    }

}


//setup RestKit object for api call(s)
-(void)configureRestKit{
    
    //initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://skinscope.info"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    //initialize RestKit
    objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    //create response descriptor
    RKObjectMapping *emptyMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emptyMapping method:RKRequestMethodGET pathPattern:@"/api/users/auth" keyPath:@"" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
}


//attempt to login using supplied credentials
-(IBAction)attemptLogin:(id)sender{
    
    //dismiss the keyboard
    [self.view endEditing:YES];
    
    //show activity indicator
    [spinner startAnimating];
    
    //setup header for authentication
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:self.email.text password:self.password.text];
    
    
    
    //make the call
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/users/auth" parameters:nil
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            
            [spinner stopAnimating];
            
            //save account information to keychain
            [SSKeychain setPassword:self.password.text forService:@"SkinScope.com" account:self.email.text];
            
            //setup user
            User *sharedUser = [User sharedUser];
            [sharedUser setUsername:self.email.text];
            [sharedUser setPassword:self.password.text];
            
            [self pushSearchVC];
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            [spinner stopAnimating];
            
            //authentication failed, show error message
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error with your E-Mail and Password combination. Please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
     ];
    
}


#pragma mark Segue

//segue to the product search view controller
-(void)pushSearchVC{
    [self performSegueWithIdentifier:@"pushSearchVC" sender:self];
}




@end
