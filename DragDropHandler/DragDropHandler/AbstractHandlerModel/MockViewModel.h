//
//  MockViewModel.h
//  DragDropHandler
//
//  Created by Thuc Nguyen on 27/01/2021.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockViewModel : NSObject<DataProviderProtocols>

@property (nonatomic) DataProvider * _Nonnull provider;

@property (nonatomic) NSMutableArray * _Nullable modelsListAfterBuildDataSource;

@property (nonatomic) NSMutableArray * _Nullable models;

- (void)buildDataSource;
- (instancetype)initWithModel:(id)models;
- (void)setupProvider;

@end

NS_ASSUME_NONNULL_END
