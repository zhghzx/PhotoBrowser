//
//  ZXPhotoView.m
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/24.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import "ZXPhotoView.h"
#import "UIImageView+WebCache.h"
#import <Photos/Photos.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZXPhotoView ()

@property (nonatomic, copy) UIImage *currentImage;

@end

@implementation ZXPhotoView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self.scrollContentView addGestureRecognizer:singleTap];
}

- (void)setImageUrlStr:(NSString *)imageUrlStr {
    _saveBtn.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrlStr] options:SDWebImageCacheMemoryOnly progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished && image) {
            [weakSelf setImageWith:image];
        }
    }];
}

- (void)setImageWith:(UIImage *)image {
    CGSize imgSize = image.size;
    float imageScale = imgSize.width/imgSize.height;
    float h = SCREEN_WIDTH/imageScale;
    _imageViewHeight.constant = h;
    if (h>SCREEN_HEIGHT) {
        _scrollContentViewHeight.constant = h;
    }
    _imageView.image = image;
    self.currentImage = image;
    _saveBtn.hidden = NO;
}

- (IBAction)saveImage:(id)sender {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.currentImage];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"保存成功");
        }   else if (error) {
            NSLog(@"保存失败");
        }
    }];
}

- (void)tapHandle:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(singleTap)]) {
        [self.delegate singleTap];
    }
}

@end
