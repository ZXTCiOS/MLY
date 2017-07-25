//
//  SearchViewController.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (nonatomic, assign) SearchType type;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.searchBarStyle = UISearchBarIconSearch;
    
    
    
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithSearchType:(SearchType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}


@end
