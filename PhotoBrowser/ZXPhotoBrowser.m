//
//  ZXPhotoBrowser.m
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/18.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import "ZXPhotoBrowser.h"
#import "ZXPhotoView.h"
#import <Photos/Photos.h>

#define SaveBtnW 80
#define SaveBtnH 30

@interface ZXPhotoBrowser ()<UICollectionViewDelegate, UICollectionViewDataSource, ZXPhotoViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *saveBtn;//保存按钮
@property (nonatomic, strong) UIImage *currentImage;//当前图片
@property (nonatomic, strong) UILabel *indicatorLabel;//顶部提示


@end

@implementation ZXPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    [self setupUI];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    [self.view addSubview:self.saveBtn];
    [self.view bringSubviewToFront:self.saveBtn];
    if (self.dataSource.count > 1 ) {
        [self.view addSubview:self.indicatorLabel];
        [self.view bringSubviewToFront:self.indicatorLabel];
        self.indicatorLabel.text = [NSString stringWithFormat:@"%lu / %lu", self.index+1, self.dataSource.count];
    }
    
}

#pragma mark -UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXPhotoView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZXPhotoView" forIndexPath:indexPath];
    cell.delegate = self;
    if ([self.dataSource[indexPath.item] isKindOfClass:[NSString class]]) {
        cell.imageUrlStr = self.dataSource[indexPath.item];
    }   else if ([self.dataSource[indexPath.item] isKindOfClass:[UIImage class]]) {
        cell.image = self.dataSource[indexPath.item];
    }
    return cell;
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x <= 0) {
        return;
    }
    NSUInteger index = scrollView.contentOffset.x/SCREEN_WIDTH + 1;
    if ((NSUInteger)scrollView.contentOffset.x%(NSUInteger)SCREEN_WIDTH >= SCREEN_WIDTH/2) {
        index += 1;
    }
    self.indicatorLabel.text = [NSString stringWithFormat:@"%lu / %lu", index, self.dataSource.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

#pragma mark -ZXPhotoViewDelegate
- (void)loadImageWith:(ZXLoadImageState)state and:(UIImage *)image {
    if (state == ZXLoadImageStateSuccess) {
        self.currentImage = image;
        self.saveBtn.hidden = NO;
    }   else {
        self.saveBtn.hidden = YES;
    }
}

- (void)singleTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)panGestureHandleDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
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

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(SCREEN_WIDTH-SaveBtnW-25, SCREEN_HEIGHT-SaveBtnH-25, SaveBtnW, SaveBtnH);
        [_saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.hidden = YES;
    }
    return _saveBtn;
}

- (UILabel *)indicatorLabel {
    if (_indicatorLabel == nil) {
        _indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 20)];
        _indicatorLabel.textAlignment = NSTextAlignmentCenter;
        _indicatorLabel.font = [UIFont systemFontOfSize:16];
        _indicatorLabel.textColor = [UIColor whiteColor];
    }
    return _indicatorLabel;
}

- (void)saveImage {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.currentImage];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"保存成功");
        }   else if (error) {
            NSLog(@"保存失败:%@", error);
        }
    }];
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
