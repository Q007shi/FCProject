//
//  ViewController.m
//  FCProject
//
//  Created by Ganggang Xie on 2019/12/21.
//  Copyright © 2019 Ganggang Xie. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
//Model
#import "FCSectionModel.h"
//View
#import "TableViewCell.h"
//Controller
#import "FCScrollViewBaseVC.h"
#import "FCViewTintColorVC.h"

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
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    unsigned int *num = malloc(sizeof(unsigned int));
    Ivar *ivarP = class_copyIvarList(tableView.class, num);
    NSLog(@"------");
    for (int t = 0; t < *num; t++) {
        Ivar ivar = *(ivarP + t);
        const char *type = ivar_getTypeEncoding(ivar);
        const char *name = ivar_getName(ivar);
        NSLog(@"%s:%s\n",name,type);

    }
    //
    UIView *indexView = [tableView valueForKey:@"index"];
    if (indexView) {
        indexView.backgroundColor = [UIColor colorWithRed:0.4 green:0.1 blue:0.9 alpha:0.5];
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
        cellM1_1.classVC = FCScrollViewBaseVC.class;//
        [sectionM1.cells addObject:cellM1_1];
        
        FCCellModel *cellM1_2 = FCCellModel.new;
        cellM1_2.title = @"UIView的TintColor";
        cellM1_2.classVC = FCViewTintColorVC.class;//
        [sectionM1.cells addObject:cellM1_2];
        
    }
    return _mArr;
}

@end
