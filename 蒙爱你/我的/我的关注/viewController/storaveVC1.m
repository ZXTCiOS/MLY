//
//  storaveVC1.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "storaveVC1.h"
#import "travelCell.h"

@interface storaveVC1 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) UICollectionView *myCollectionV;
@end

static NSString *indentify = @"indentify";

@implementation storaveVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTheCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

//创建视图

-(void)addTheCollectionView{
    
    //=======================1===========================
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    
    //格子的大小 (长，高)
    flowL.itemSize = CGSizeMake(170*WIDTH_SCALE, 190*HEIGHT_SCALE);
    //横向最小距离
    flowL.minimumInteritemSpacing = 1.f;
    //    flowL.minimumLineSpacing=60.f;//代表的是纵向的空间间隔
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowL.sectionInset = UIEdgeInsetsMake(16*HEIGHT_SCALE, 14*WIDTH_SCALE, 4*HEIGHT_SCALE, 14*WIDTH_SCALE);
    
    //创建一个UICollectionView
    _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -8, kScreenW, kScreenH-64-44) collectionViewLayout:flowL];
    //设置代理为当前控制器
    _myCollectionV.backgroundColor = [UIColor whiteColor];
    _myCollectionV.delegate = self;
    _myCollectionV.dataSource = self;
    
    
    [_myCollectionV registerClass:[travelCell class] forCellWithReuseIdentifier:indentify];
    
    //添加视图
    [self.view addSubview:_myCollectionV];
    
}

#pragma mark --UICollectionView dataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化每个单元格
    travelCell *cell = (travelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
    
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    

}

@end
