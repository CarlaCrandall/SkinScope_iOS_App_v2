//
//  AddReviewViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "AddReviewViewController.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Review.h"
#import "SSKeychain.h"

@interface AddReviewViewController ()

@end

@implementation AddReviewViewController

@synthesize writeReviewLabel, reviewText, submitBtn, clearBtn, product, spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //set nav bar title
    self.title = product.name;
    
    
    //set background image
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    
    //set fonts
    [writeReviewLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    [reviewText setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:14]];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    clearBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    
    //change appearance of text view
    reviewText.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    reviewText.layer.borderWidth = 0.5f;
    reviewText.layer.borderColor = [[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Text View Functions


//clear text from text view
-(IBAction)clearReviewText{
    reviewText.text = @"";
}


//tapping outside the search bar will dimiss the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [reviewText resignFirstResponder];
}


//hide keyboard when user hits return key
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    //if return key was pressed
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder]; //hide the keyboard
        return NO;
    }
    
    return YES;
}



#pragma mark API Call Functions


//attempt to add review to database
-(IBAction)submitReview{
    
    //start activity indicator
    [spinner startAnimating];
    
    //create post url
    NSString *addReviewURL = [NSString stringWithFormat:@"/api/products/%i/reviews/create", product.productID];
    

    NSArray *accounts = [SSKeychain accountsForService:@"SkinScope.com"]; //get accounts
    NSString *username;
    NSString *password;
    
    
    //get account info
    if([accounts count] == 1){
        
        //get username & password from keychain
        username = [[accounts objectAtIndex:0] objectForKey:@"acct"];
        password = [SSKeychain passwordForService:@"SkinScope.com" account:username];
        
    }
    //if account info is not available, display error
    //shouldn't ever happen - user shouldn't be able to get to this screen without logging in
    else{
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not currently logged in." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    
    
    //setup header for authentication
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:username password:password];
    
    
    
    //make the call
    [[RKObjectManager sharedManager] postObject:nil path:addReviewURL parameters:@{@"review": reviewText.text}
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
            
            //stop activity indicator
            [spinner stopAnimating];
            
            //clear text view
            reviewText.text = @"";
            
            //display success message
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your review has been submitted." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [successAlert show];
        
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error){
            
            //stop activity indicator
            [spinner stopAnimating];
            
            //display error message
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was a problem submitting your review. Please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
     ];
    
    
    
}



@end
