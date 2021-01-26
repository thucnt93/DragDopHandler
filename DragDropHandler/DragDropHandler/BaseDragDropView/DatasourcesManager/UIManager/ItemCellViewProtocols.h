//
//  ItemCellViewProtocols.h
//  FlowarePopover
//
//  Created by Lam Nguyen on 3/5/19.
//  Copyright © 2019 Floware Inc. All rights reserved.
//

#ifndef ItemCellViewProtocols_h
#define ItemCellViewProtocols_h


@protocol ListSupplierProtocol;

@protocol ItemCellViewProtocols <NSObject>

@optional
- (void)itemCellView:(id<ItemCellViewProtocols>_Nullable)itemCellView updateWithData:(id<ListSupplierProtocol> _Nullable)data atIndex:(NSInteger)index;
- (void)itemCellView:(id<ItemCellViewProtocols>_Nullable)itemCellView updateWithData:(id<ListSupplierProtocol> _Nullable)data atIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

#endif /* ItemCellViewProtocols_h */
