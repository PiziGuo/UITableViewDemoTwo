//
//  ViewController.m
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "ViewController.h"
#import "GDetailCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *floorArr;

@property (nonatomic, strong) NSMutableArray *cellAccountArr;


@end


static NSString *kCellID = @"cellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.floorArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellAccountArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDetailCell *cell = [GDetailCell cellWithTableView:tableView];
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - 

- (NSMutableArray *)floorArr {
    if (!_floorArr) {
        _floorArr = [NSMutableArray array];
        
        NSDictionary *detailDict = @{
                                     @"distance":@"",
                                     @"type":@""
                                     };
        [_floorArr addObject:detailDict];
        
    }
    return _floorArr;
}

- (NSMutableArray *)cellAccountArr {
    if (!_cellAccountArr) {
        _cellAccountArr = [NSMutableArray arrayWithObject:@"1"];
    }
    return _cellAccountArr;
}


@end
