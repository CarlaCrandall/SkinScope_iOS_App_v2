//
//  Dropdown.m
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/15/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//
//  Code for custom drop down from here: http://rogchap.com/2013/08/13/simple-ios-dropdown-control-using-uitextfield/

#import "Dropdown.h"
#import "DropdownArrowView.h"


@implementation Dropdown{
    UIPickerView* _pickerView;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        
        //create dropdown arrow
        self.rightView = [DropdownArrowView default];
        self.rightViewMode = UITextFieldViewModeAlways;
        
        //setup picker
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.showsSelectionIndicator = YES;
        
        //set input to picker instead of keyboard
        self.inputView = _pickerView;
    }
    
    return self;
}


//prevent copy/cut/paste/select actions from showing up when user double clicks the dropdown
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:) || action == @selector(cut:) || action == @selector(copy:) || action == @selector(select:) || action == @selector(selectAll:)){
        
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}


//prevent user from typing in the category dropdown field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return NO;
}


-(void)setTag:(NSInteger)tag{
    [super setTag:tag];
    _pickerView.tag = tag;
}


-(void)setPickerDelegate:(id<UIPickerViewDelegate>)pickerDelegate{
    _pickerView.delegate = pickerDelegate;
}


-(void)setPickerDataSource:(id<UIPickerViewDataSource>)pickerDataSource{
    _pickerView.dataSource = pickerDataSource;
}


@end
