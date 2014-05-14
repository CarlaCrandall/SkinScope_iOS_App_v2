//
//  IngredientsListViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/13/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "IngredientsListViewController.h"
#import <RestKit/RestKit.h>
#import "Ingredient.h"
#import "IngredientViewController.h"

@interface IngredientsListViewController ()

@end

@implementation IngredientsListViewController

@synthesize ingredientsLabel, filterButton, ingredientsList, pageIndex, filterRating, product, ingredients, ingredient, spinner;

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
    
    //clear background allows background image of page view controller to show through
    self.view.backgroundColor = [UIColor clearColor];
    
    //change font of labels
    [ingredientsLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    
    //prevent table cell left indentation
    [ingredientsList setSeparatorInset:UIEdgeInsetsZero];
    
    //don't filter ingredients by default
    filterRating = @"";
    
    //get ingredients
    [self getIngredients];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Table View Functions


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //if there are no reviews, display a message
    if(ingredients.count == 0){
        return 1;
    }
    //else display the reviews
    else{
        return ingredients.count;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    //if there are reviews, display them
    if(ingredients.count > 0){
        
        //create cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IngredientCell" forIndexPath:indexPath];
        
        //get ingredient
        Ingredient *rowIngredient = [ingredients objectAtIndex:indexPath.row];
        
        //set table cell image based on ingredient rating
        if([[rowIngredient rating] isEqualToString:@"Good"]){
            cell.imageView.image = [UIImage imageNamed:@"good.png"];
        }
        else if([[rowIngredient rating] isEqualToString:@"Average"]){
            cell.imageView.image = [UIImage imageNamed:@"average.png"];
        }
        else if([[rowIngredient rating] isEqualToString:@"Poor"]){
            cell.imageView.image = [UIImage imageNamed:@"poor.png"];
        }
        else{
            cell.imageView.image = [UIImage imageNamed:@"unknown.png"];
        }
        
        //set ingredient name
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        cell.textLabel.text = [rowIngredient name];
        
        return cell;
    }
    //if there are no reviews, display a message
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoResultsCell" forIndexPath:indexPath];
        
        //display message
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        cell.textLabel.text = @"No ingredients found.";
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // get product
    ingredient = [ingredients objectAtIndex:indexPath.row];
    
    //push next view controller
    [self pushIngredientVC];
}



#pragma mark API Call Functions


-(void)getIngredients{
    
    //show activity indicator
    [spinner startAnimating];
    
    //setup query url
    NSString *ingredientsURL = [NSString stringWithFormat:@"/api/products/%i/ingredients", product.productID];
    
    //setup query parameters
    NSDictionary *queryParams;
    
    
    //if no skin type is specified, don't filter results
    if([filterRating isEqualToString:@""]){
        queryParams = nil;
    }
    //filter results based on skin type
    else{
        queryParams = @{@"rating" : filterRating};
    }
    
    //make the call
    [[RKObjectManager sharedManager] getObjectsAtPath:ingredientsURL parameters:queryParams
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            
            [spinner stopAnimating]; //hide activity indicator
            
            ingredients = mappingResult.array; //store reviews
            [ingredientsList reloadData]; //show the reviews
                                                  
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            [spinner stopAnimating]; //hide activity indicator
            
            ingredients = [NSArray array]; //empty the array
            [ingredientsList reloadData]; //display a message
        }
     ];
}


//display action sheet modal with filter options
-(IBAction)showFilterModal{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"   Filter by Rating" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"All Results",
                            @"Good",
                            @"Average",
                            @"Poor",
                            @"Unknown",
                            nil];
    
    //show action sheet
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}


//customize action sheet title and buttons
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    
    for (UIView *subview in actionSheet.subviews) {
        
        //customize buttons
        if ([subview isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)subview;
            
            //set color
            [button setTitleColor:[UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1] forState:UIControlStateNormal];
            
            //set font
            [button.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
            
            //set alignment and padding
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0.0, 25.0, 0.0, 0.0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)];
            
            //custom padding on cancel button since it does not have an image
            if([button.titleLabel.text isEqualToString:@"Cancel"]){
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
            }
            
            //add icons to action sheet buttons
            if([button.titleLabel.text isEqualToString:@"All Results"]){
                [button setImage:[UIImage imageNamed:@"allResults.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Good"]){
                [button setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Average"]){
                [button setImage:[UIImage imageNamed:@"average.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Poor"]){
                [button setImage:[UIImage imageNamed:@"poor.png"] forState:UIControlStateNormal];
            }
            else if([button.titleLabel.text isEqualToString:@"Unknown"]){
                [button setImage:[UIImage imageNamed:@"unknown.png"] forState:UIControlStateNormal];
            }
        }
        //customize title
        else if ([subview isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *)subview;
            
            //set color
            [label setTextColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1]];
            
            //set font
            [label setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
            
            //set alignment
            [label setTextAlignment:NSTextAlignmentLeft];
        }
    }
}


//filter results
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //set filter
    switch (buttonIndex) {
            
            //all ingredients
        case 0:
            filterRating = @"";
            break;
            
            //good
        case 1:
            filterRating = @"Good";
            break;
            
            //average
        case 2:
            filterRating = @"Average";
            break;
            
            //poor
        case 3:
            filterRating = @"Poor";
            break;
            
            //unknown
        case 4:
            filterRating = @"Unknown";
            break;
            
            //default
        default:
            filterRating = @"";
            break;
    }
    
    //filter reviews
    [self getIngredients];
}




#pragma mark Segue


-(void)pushIngredientVC{
    [self performSegueWithIdentifier:@"pushIngredientVC" sender:self];
}


//pass ingredient to next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushIngredientVC"]) {
        
        // Get destination view
        IngredientViewController *ingredientViewController = [segue destinationViewController];
        
        // Pass the product to destination view
        [ingredientViewController setIngredient:ingredient];
    }
}


@end
