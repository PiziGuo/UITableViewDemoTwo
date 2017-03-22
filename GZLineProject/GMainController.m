//
//  GMainController.m
//  GZLineProject
//
//  Created by David on 2017/3/22.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "GMainController.h"
#import "GDetailCell.h"
#import "GHeaderView.h"
#import "GTextField.h"
#import "UIView+Additon.h"
@interface GMainController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *floorArr;

@property (nonatomic, strong) NSMutableArray *cellDetailArr;

@end

static NSString *distanceKey = @"distance";
static NSString *typeKey = @"type";

@implementation GMainController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}

- (void)initViews {
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(GTextField *)textField {
    
    NSLog(@"%@",textField.indexPath);
    NSIndexPath *indexPath = textField.indexPath;
    
    NSMutableArray *cellDetailArr = self.floorArr[indexPath.section];
    
    NSDictionary *tempDict = cellDetailArr[indexPath.row];
    NSMutableDictionary *detailDict = [NSMutableDictionary dictionaryWithDictionary:tempDict];
    
    if (textField.type == GTextFieldTypeDistance) {
        [detailDict setObject:textField.text forKey:distanceKey];
    } else if (textField.type == GTextFieldTypeLineType){
        [detailDict setObject:textField.text forKey:typeKey];
        
        
    } else {
        
    }
    [cellDetailArr replaceObjectAtIndex:indexPath.row withObject:detailDict];
    
    [self.floorArr replaceObjectAtIndex:indexPath.section withObject:cellDetailArr];
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
   [textField resignFirstResponder];
    return YES;
}


#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.floorArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *cellDetailArr = self.floorArr[section];
    
    return cellDetailArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDetailCell *cell = [GDetailCell cellWithTableView:tableView];
    
    cell.distanceTextField.delegate = self;
    cell.distanceTextField.indexPath = indexPath;
    
    cell.typeTextField.delegate = self;
    cell.typeTextField.indexPath = indexPath;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    GHeaderView *view = [[GHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) andFloorData:self.floorArr];
    view.floorText = [NSString stringWithFormat:@"第%ld层",(long)section + 1];
    view.heightTextField.delegate = self;
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    [addBtn setTitle:@"添加点" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [view addSubview:addBtn];
    addBtn.tag = section;
    [addBtn addTarget:self action:@selector(addDetailTypeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

// 添加点
- (void)addDetailTypeBtnClicked:(UIButton *)addBtn {
    
    NSMutableArray *cellDetailArr = self.floorArr[addBtn.tag];
    
    NSDictionary *detailDict = @{
                                 @"distance":@"",
                                 @"type":@""
                                 };
    
    [cellDetailArr addObject:detailDict];
    
    [self.floorArr replaceObjectAtIndex:addBtn.tag withObject:cellDetailArr];
    
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:cellDetailArr.count - 1 inSection:addBtn.tag];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
    
    [self.tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 20;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 执行删除的操作
        NSMutableArray *cellDetailArr = self.floorArr[indexPath.section];
        
        [cellDetailArr removeObjectAtIndex:indexPath.row];
       
        [self.floorArr replaceObjectAtIndex:indexPath.section withObject:cellDetailArr];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        
        [tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        
        if (cellDetailArr.count == 0) {
            
            [self.floorArr removeObjectAtIndex:indexPath.section];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
            [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }
        
    } else {
        
        
        
    }
    
}



- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


#pragma mark - NSNotification
- (void)keyboardAppear:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGFloat keyboardEndY = value.CGRectValue.size.height;// 键盘高度
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
       
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - keyboardEndY);
        
    }];
}


- (void)keyboardDisappear:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
       
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
    }];
    
}


#pragma mark - event response 

// 添加新楼层(添加分组)
- (IBAction)addNewFloor:(id)sender {
    
    NSMutableArray *cellDetailArr = [NSMutableArray array];
    NSDictionary *detailDict = @{
                                 @"distance":@"",
                                 @"type":@""
                                 };
    [cellDetailArr addObject:detailDict];
    
    [self.floorArr addObject:cellDetailArr];
    
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:self.floorArr.count - 1];
    
    [self.tableView beginUpdates];
    [self.tableView insertSections:index withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
    // 滑动到底部
    if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
        
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:YES];
    }
    
    
    
}


#pragma mark - lazy initialize

- (NSMutableArray *)floorArr {
    if (!_floorArr) {
        _floorArr = [NSMutableArray array];
        
        [_floorArr addObject:self.cellDetailArr];
        
    }
    return _floorArr;
}

- (NSMutableArray *)cellDetailArr {
    if (!_cellDetailArr) {
        _cellDetailArr = [NSMutableArray array];
        NSDictionary *detailDict = @{
                                     @"distance":@"",
                                     @"type":@""
                                     };
        
        [_cellDetailArr addObject:detailDict];
    }
    return _cellDetailArr;
}



@end
