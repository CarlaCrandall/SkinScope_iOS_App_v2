//
//  ReviewsViewController.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/12/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//

#import "ReviewsViewController.h"
#import <RestKit/RestKit.h>
#import "Review.h"
#import "CustomReviewCell.h"

@interface ReviewsViewController ()

@end

@implementation ReviewsViewController

@synthesize reviewsLabel, composeButton, filterButton, pageIndex, product, reviews, reviewsList, filterSkinType, prototypeCell, spinner;

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
    [reviewsLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:18]];
    
    //prevent table cell left indentation
    [reviewsList setSeparatorInset:UIEdgeInsetsZero];
    
    //don't filter reviews by default
    filterSkinType = @"";
    
    //get reviews for the product
    [self getReviews];
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
    if(reviews.count == 0){
        return 1;
    }
    //else display the reviews
    else{
        return reviews.count;
    }
    
}


//configure review table cells
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[CustomReviewCell class]]){
        
        CustomReviewCell *reviewCell = (CustomReviewCell *)cell;
        Review *rowReview = [reviews objectAtIndex:indexPath.row];
        
        //set review user
        reviewCell.username.font = [UIFont fontWithName:@"ProximaNova-Bold" size:14];
        reviewCell.username.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        reviewCell.username.text = [rowReview user];
        
        //set review skin type
        reviewCell.skinTypeLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:10];
        reviewCell.skinTypeLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        reviewCell.skinType.font = [UIFont fontWithName:@"ProximaNova-Regular" size:10];
        reviewCell.skinType.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        reviewCell.skinType.text = [rowReview skin_type];
        
        //set review text
        reviewCell.review.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
        reviewCell.review.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        reviewCell.review.text = [rowReview review];
        
        //figure out height of review label
        NSString *text = reviewCell.review.text;
        CGFloat lineHeight = reviewCell.review.font.lineHeight;
        
        CGFloat lines;
        
        //if text is less than one line, height is equal to lineHeight
        if(text.length / 35.0f < 1){
            lines = lineHeight;
        }
        //if text is more than one line, calculate height
        else{
            lines = (text.length / 35.0f) * lineHeight;
        }
        
        //resize review label
        reviewCell.review.frame = CGRectMake(reviewCell.review.frame.origin.x, reviewCell.review.frame.origin.y, reviewCell.review.frame.size.width, lines);
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
        
    //if there are reviews, display them
    if(reviews.count > 0){
        
        //create cell
        CustomReviewCell *cell = (CustomReviewCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomReviewCell" forIndexPath:indexPath];
        
        //configure cell
        [self configureCell:cell forRowAtIndexPath:indexPath];
        
        return cell;
    }
    //if there are no reviews, display a message
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoResultsCell" forIndexPath:indexPath];
        
        //display message
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1];
        cell.textLabel.text = @"No reviews found.";
        
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //calculate height for reviews
    if(reviews.count > 0){
        
        //create a prototype cell
        [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
        
        //figure out height of review label
        UILabel *contentLabel = prototypeCell.review;
        NSString *text = prototypeCell.review.text;
        CGFloat lineHeight = contentLabel.font.lineHeight;
        
        CGFloat lines;
        
        //if text is less than one line, height is equal to lineHeight
        if(text.length / 35.0f < 1){
            lines = lineHeight;
        }
        //if text is more than one line, calculate height
        else{
            lines = (text.length / 35.0f) * lineHeight;
        }
        
        //add on height for the rest of the labels
        CGFloat height = lines + 70.0f;
        
        //return dynamic height
        return height;
        
    }
    //if no reviews, return default height
    else{
        return 44;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"User selected row");
}


//getter for prototype cell - used to calculate dynamic cell height
-(CustomReviewCell *)prototypeCell{
    
    if (!prototypeCell){
        prototypeCell = [self.reviewsList dequeueReusableCellWithIdentifier:@"CustomReviewCell"];
    }
    return prototypeCell;
}



#pragma mark API Call Functions


-(void)getReviews{
    
    //show activity indicator
    [spinner startAnimating];
    
    //setup query url
    NSString *reviewsURL = [NSString stringWithFormat:@"/api/products/%i/reviews", product.productID];
    
    //setup query parameters
    NSDictionary *queryParams;
    
    
    //if no skin type is specified, don't filter results
    if([filterSkinType isEqualToString:@""]){
        queryParams = nil;
    }
    //filter results based on skin type
    else{
        queryParams = @{@"skin_type" : filterSkinType};
    }
    
    //make the call
    [[RKObjectManager sharedManager] getObjectsAtPath:reviewsURL parameters:queryParams
        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            
            [spinner stopAnimating]; //hide activity indicator
            
            reviews = mappingResult.array; //store reviews
            [reviewsList reloadData]; //show the reviews
                                                  
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            
            [spinner stopAnimating]; //hide activity indicator
                                                  
            reviews = [NSArray array]; //empty the array
            [reviewsList reloadData]; //display a message
        }
     ];
}


//display action sheet modal with filter options
-(IBAction)showFilterModal{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"   Filter by Skin Type" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"All Results",
                            @"Normal",
                            @"Oily",
                            @"Dry",
                            @"Sensitive",
                            @"Combination",
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
            
        //all reviews
        case 0:
            filterSkinType = @"";
            break;
            
        //normal
        case 1:
            filterSkinType = @"Normal";
            break;
            
        //oily
        case 2:
            filterSkinType = @"Oily";
            break;
            
        //dry
        case 3:
            filterSkinType = @"Dry";
            break;
            
        //sensitive
        case 4:
            filterSkinType = @"Sensitive";
            break;
            
        //combination
        case 5:
            filterSkinType = @"Combination";
            break;
            
        //default
        default:
            filterSkinType = @"";
            break;
    }
    
    //filter reviews
    [self getReviews];
}

@end
