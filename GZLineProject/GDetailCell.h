//
//  GDetailCell.h
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTextField;
@interface GDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet GTextField *distanceTextField;
@property (weak, nonatomic) IBOutlet GTextField *typeTextField;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
