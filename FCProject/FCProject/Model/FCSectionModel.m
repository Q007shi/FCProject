//
//  FCSectionModel.m
//  FCProject
//
//  Created by Ganggang Xie on 2019/12/21.
//  Copyright © 2019 Ganggang Xie. All rights reserved.
//

#import "FCSectionModel.h"

@implementation FCSectionModel

- (NSMutableArray<FCCellModel *> *)cells{
    if (!_cells) {
        _cells = NSMutableArray.array;
    }
    return _cells;
}

@end

@implementation FCCellModel

@end
