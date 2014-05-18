//
//  DropdownArrowView.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/14/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//
//  Code for custom drop down from here: http://rogchap.com/2013/08/13/simple-ios-dropdown-control-using-uitextfield/

#import "DropdownArrowView.h"

@implementation DropdownArrowView


//create dropdown arrow
+(DropdownArrowView*) default{
    
    DropdownArrowView* view = [[DropdownArrowView alloc] initWithFrame:CGRectMake(0, 0, 43, 28)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


//draw dropdown arrow
-(void)drawRect:(CGRect)rect{
    
    //set stroke color
    UIColor* strokeColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    //create frame
    CGRect frame = self.bounds;
    
    //bezier drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 24.82, CGRectGetMinY(frame) + 8.08)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 25.98, CGRectGetMinY(frame) + 9.25)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 17.01, CGRectGetMinY(frame) + 18.22)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 17.01, CGRectGetMinY(frame) + 18.22)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 15.85, CGRectGetMinY(frame) + 19.38)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 15.85, CGRectGetMinY(frame) + 19.38)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 15.85, CGRectGetMinY(frame) + 19.38)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 14.68, CGRectGetMinY(frame) + 18.22)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 14.68, CGRectGetMinY(frame) + 18.22)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 5.71, CGRectGetMinY(frame) + 9.25)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 6.88, CGRectGetMinY(frame) + 8.08)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 15.85, CGRectGetMinY(frame) + 17.05)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 24.82, CGRectGetMinY(frame) + 8.08)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    bezierPath.usesEvenOddFillRule = YES;
    [strokeColor setFill];
    [bezierPath fill];
}

@end
