//
//  ZXPhotoBrowser.m
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/18.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import "ZXPhotoBrowser.h"
#import "ZXPhotoView.h"

@interface ZXPhotoBrowser ()<UICollectionViewDelegate, UICollectionViewDataSource, ZXPhotoViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZXPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXPhotoView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZXPhotoView" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZXPhotoView alloc] init];
    }
    cell.imageUrlStr = self.dataSource[indexPath.item];
    cell.delegate = self;
    return cell;
}

#pragma mark -ZXPhotoViewDelegate
- (void)singleTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"ZXPhotoView" bundle:nil] forCellWithReuseIdentifier:@"ZXPhotoView"];
    }
    return _collectionView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
