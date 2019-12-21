//
//  FCSectionModel.h
//  FCProject
//
//  Created by Ganggang Xie on 2019/12/21.
//  Copyright © 2019 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FCCellModel;
@interface FCSectionModel : NSObject

/** <#aaa#> */
@property (nonatomic, assign) CGFloat headerHeight;
/** <#aaa#> */
@property (nonatomic, copy) NSString *headerTitle;
/** <#aaa#> */
@property (nonatomic, assign) CGFloat footerHeight;
/** <#aaa#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#aaa#> */
@property (nonatomic, strong) NSMutableArray<FCCellModel *> *cells;

@end

@interface FCCellModel : NSObject

/** <#aaa#> */
@property (nonatomic, assign) CGFloat height;
/** <#aaa#> */
@property (nonatomic, copy) NSString *title;

@property Class classVC;


@end
