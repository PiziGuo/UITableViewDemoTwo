//
//  GHeaderView.m
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "GHeaderView.h"
#import "GTextField.h"

@implementation GHeaderView

- (instancetype)initWithFrame:(CGRect)frame andFloorData:(NSArray *)floorData {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self initViews];
        
    }
    return self;
}


- (void)initViews {
    
    
    UILabel *floor = [[UILabel alloc] init];
    floor.frame = CGRectMake(16, 0, 60, self.frame.size.height);
    self.floorLabel = floor;
    [self addSubview:self.floorLabel];
    
    
    GTextField *height = [[GTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(floor.frame), 10, self.frame.size.width - CGRectGetMaxX(floor.frame) - 40, self.frame.size.height - 20)];
    height.borderStyle = UITextBorderStyleRoundedRect;
    height.placeholder = @"请输入层高";
    height.textAlignment = NSTextAlignmentCenter;
    height.type = GTextFieldTypeFloorHeight;
    self.heightTextField = height;
    [self addSubview:self.heightTextField];
   
}

- (void)setFloorText:(NSString *)floorText {
    
    _floorText = floorText;
    
    self.floorLabel.text = floorText;
    
}

@end
