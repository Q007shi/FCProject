//
//  ViewController.m
//  FCProject
//
//  Created by Ganggang Xie on 2019/12/21.
//  Copyright © 2019 Ganggang Xie. All rights reserved.
//

#import "ViewController.h"
//Model
#import "FCSectionModel.h"
//View
#import "TableViewCell.h"
//Controller
#import "FCScrollViewBaseVC.h"

@interface ViewController ()

/** 分组数据 */
@property (nonatomic, strong) NSMutableArray<FCSectionModel *> *mArr;

/** <#aaa#> */
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ViewController

//自定义 UITableViewIndex
//https://www.jianshu.com/p/f598122056fb


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基础操作";
    //
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.tableFooterView = UIView.new;
    //
    [self.tableView registerClass:TableViewCell.class forCellReuseIdentifier:NSStringFromClass(TableViewCell.class)];
    [self.tableView registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(UITableViewHeaderFooterView.class)];
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArr[section].cells.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewCell.class) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.mArr[indexPath.section].cells[indexPath.row].title;
    return cell;
}

///MARK: 设置索引条
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *mArr = NSMutableArray.array;
    [mArr addObject:UITableViewIndexSearch];
    for (FCSectionModel *model in self.mArr) {
        [mArr addObject:model.headerTitle ? model.headerTitle : @"-"];
    }
    return mArr;
}///MARK: 索引条事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (index == 0) {
        [tableView scrollRectToVisible:self.searchBar.frame animated:YES];
        return -1;
    }
    return index-1;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.mArr[section].headerHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(UITableViewHeaderFooterView.class)];
    headerView.textLabel.text = self.mArr[section].headerTitle;
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.mArr[indexPath.section].cells[indexPath.row].classVC) {
        [self.navigationController pushViewController:self.mArr[indexPath.section].cells[indexPath.row].classVC.new animated:YES];
    }
}



#pragma mark - getter 方法
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 44)];
    }
    return _searchBar;
}

- (NSMutableArray<FCSectionModel *> *)mArr{
    if (!_mArr) {
        _mArr = NSMutableArray.array;
        //
        FCSectionModel *sectionM1 = FCSectionModel.new;
        sectionM1.headerHeight = 30;
        sectionM1.headerTitle = NSStringFromClass(UIScrollView.class);
        sectionM1.footerHeight = 0;
        [_mArr addObject:sectionM1];
        
        FCCellModel *cellM1_1 = FCCellModel.new;
        cellM1_1.title = @"基本属性和方法";
        cellM1_1.classVC = FCScrollViewBaseVC.class;
        
        [sectionM1.cells addObject:cellM1_1];
        
    }
    return _mArr;
}

@end
