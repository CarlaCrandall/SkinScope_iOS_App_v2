//
//  Dropdown.h
//  SkinScope_v2
//
//  Created by Carla Crandall on 5/15/14.
//  Copyright (c) 2014 Carla Crandall. All rights reserved.
//
//  Code for custom drop down from here: http://rogchap.com/2013/08/13/simple-ios-dropdown-control-using-uitextfield/

#import <UIKit/UIKit.h>

@interface Dropdown : UITextField

@property (nonatomic) id<UIPickerViewDelegate> pickerDelegate;
@property (nonatomic) id<UIPickerViewDataSource> pickerDataSource;

@end
