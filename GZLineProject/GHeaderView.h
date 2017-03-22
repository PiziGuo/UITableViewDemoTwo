//
//  GHeaderView.h
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTextField;
@interface GHeaderView : UIView


@property (nonatomic, strong) NSString *floorText;

@property (nonatomic, strong) UILabel *floorLabel;

@property (nonatomic, strong) GTextField *heightTextField;

- (instancetype)initWithFrame:(CGRect)frame andFloorData:(NSArray *)floorData;

@end
