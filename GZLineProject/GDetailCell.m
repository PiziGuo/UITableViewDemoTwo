//
//  GDetailCell.m
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "GDetailCell.h"
#import "GTextField.h"


static NSString *ID = @"detailCell";

@implementation GDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    GDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GDetailCell" owner:self options:nil] lastObject];
        
    }
    cell.distanceTextField.type = GTextFieldTypeDistance;
    cell.typeTextField.type = GTextFieldTypeLineType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

@end
