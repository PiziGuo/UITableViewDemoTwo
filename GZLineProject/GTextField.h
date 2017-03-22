//
//  GTextField.h
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GTextFieldType) {
    
    GTextFieldTypeDistance,
    GTextFieldTypeLineType,
    GTextFieldTypeFloorHeight
};


@interface GTextField : UITextField
// 标记textField
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, assign) GTextFieldType type;

@end
