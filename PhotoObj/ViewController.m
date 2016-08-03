//
//  ViewController.m
//  PhotoObj
//
//  Created by pengxiuxiu on 16/7/28.
//  Copyright © 2016年 pengxiuxiu. All rights reserved.
//

#import "ViewController.h"
#import "Photos.h"
#import "PhotoViewCell.h"
#import "CollectionHeaderView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)ALAssetsLibrary *assetsLibrary;
@property (nonatomic,strong)NSDictionary *imageDic;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *timeArr;

@end

@implementation ViewController


- (NSDictionary *)imageDic{
    if (!_imageDic) {
        self.imageDic = [NSDictionary dictionary];
    }
    return _imageDic;
}

- (NSArray *)timeArr{
    if (!_timeArr) {
        self.timeArr = [NSArray array];
    }
    return _timeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"试试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getOriginalImages];
    
    [self createCollection];
}

- (void)getOriginalImages{
    
    [Photos sendValueToViewController:^(NSDictionary *dataDic, NSArray *timeArr,ALAssetsLibrary *assetsLibrary) {
        self.assetsLibrary = assetsLibrary;
        self.imageDic = dataDic;
        self.timeArr = timeArr;
        [self.collectionView reloadData];
    }];
    
}


- (void)createCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(80, 80);
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoViewCell *cell = (PhotoViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.photoImage.image = [UIImage imageWithCGImage:[self.imageDic[self.timeArr[indexPath.section]][indexPath.row]thumbnail]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageDic[self.timeArr[section]] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  [self.timeArr count];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader){
        CollectionHeaderView *headerV = (CollectionHeaderView *)reusableview;
        headerV.timeLabel.text = [NSString stringWithFormat:@"拍摄于%@",
        self.timeArr[indexPath.section]];
    }
    
    return reusableview;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
