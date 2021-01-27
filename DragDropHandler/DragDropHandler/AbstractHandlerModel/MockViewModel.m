//
//  MockViewModel.m
//  TestDragDrop
//
//  Created by Thuc Nguyen on 12/01/2021.
//  Copyright © 2021 Trung Nguyen. All rights reserved.
//

#import "MockViewModel.h"


@interface MockViewModel() {
//    __weak id _modelArrays;
    NSMutableDictionary *_listViewModelsDicts;
    NSMutableDictionary *_parentItemsDictionary;
}

@end

@implementation MockViewModel


- (instancetype)initWithModel:(id)models
{
    if (self = [super init])
    {
        _models = models;
        self.provider = [[DataProvider alloc] initProviderForOwner:self];
    }
    
    return self;
}

- (DataProvider *)provider
{
    if (_provider == nil)
    {
        NSLog(@"%s-[%d] [NSThread callStackSymbols] = %@", __PRETTY_FUNCTION__, __LINE__, [NSThread callStackSymbols]);
        assert(NO);
    }
    
    return _provider;
}

- (void)setupProvider {
    if (_provider == nil) {
        _provider = [[DataProvider alloc] initProviderForOwner:self];
    }
}

- (void)buildDataSource
{
    if ([self.models isKindOfClass:[NSArray class]])
    {
        _modelsListAfterBuildDataSource = [[NSMutableArray alloc] initWithArray:(NSArray *)self.models];

        [[self provider] buildDataSource];

        [self buildListViewModelsAndParentDictionary];
    }
    else
    {
        NSLog(@"%s-[%d] [NSThread callStackSymbols] = %@", __PRETTY_FUNCTION__, __LINE__, [NSThread callStackSymbols]);
        assert(NO);
    }
}

- (void)buildListViewModelsAndParentDictionary
{
    @synchronized (_listViewModelsDicts)
    {
        if (_listViewModelsDicts == nil)
        {
            _listViewModelsDicts = [[NSMutableDictionary alloc] init];
        }
        
        if (_listViewModelsDicts.count > 0)
        {
            [_listViewModelsDicts removeAllObjects];
        }
    }
    
    @synchronized (_parentItemsDictionary)
    {
        if (_parentItemsDictionary == nil)
        {
            _parentItemsDictionary = [[NSMutableDictionary alloc] init];
        }
        
        if (_parentItemsDictionary.count > 0)
        {
            [_parentItemsDictionary removeAllObjects];
        }
    }
    
    @synchronized (_models)
    {
        [self buildListViewModelsAndParentDictionaryWithParent:nil datasource:_models];
    }
}

- (void)buildListViewModelsAndParentDictionaryWithParent:(id)parent datasource:(NSArray *)datasource
{
//    for (NSObject *item in datasource)
//    {
//        [self saveParent:parent forItem:item];
//
//        if ([item isKindOfClass:[NSDictionary class]])
//        {
//            id<IBaseViewModel> viewModel = [self viewModelForKey:item];
//
//            if (viewModel == nil)
//            {
//                viewModel = [[MenuListCellViewModel alloc] initWithModel:item];
//
//                [self setViewModel:viewModel forKey:item];
//            }
//
//            [self updateViewModel:viewModel forItem:item];
//        }
//
//        if ([item respondsToSelector:@selector(lsp_childs)] && ([(id<ListSupplierProtocol>)item lsp_childs].count > 0))
//        {
//            [self buildListViewModelsAndParentDictionaryWithParent:item datasource:[(id<ListSupplierProtocol>)item lsp_childs]];
//        }
//    }
}

- (NSMutableArray<id<ListSupplierProtocol>> *)dataSourceForProvider:(id<DataProviderProtocols>)provider {
    return (NSMutableArray<id<ListSupplierProtocol>> *)_modelsListAfterBuildDataSource;
}


@end
