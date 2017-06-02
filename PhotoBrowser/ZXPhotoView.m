//
//  ZXPhotoView.m
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/24.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import "ZXPhotoView.h"
#import "UIImageView+WebCache.h"
#import "UIView+ZXExt.h"

@interface ZXPhotoView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImage *currentImage;

@property (nonatomic, assign) CGPoint startPoint;


@end

@implementation ZXPhotoView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    //添加手势
    //单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapHandle:)];
    [self.scrollContentView addGestureRecognizer:singleTap];
    //双击
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandle:)];
//    doubleTap.numberOfTapsRequired = 2;
//    [self.scrollContentView addGestureRecognizer:doubleTap];
//    [singleTap requireGestureRecognizerToFail:doubleTap];
    //拖动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    pan.delegate = self;
    [self.imageView addGestureRecognizer:pan];
}

- (void)setImageUrlStr:(NSString *)imageUrlStr {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadImageWith:and:)]) {
        [self.delegate loadImageWith:ZXLoadImageStateStart and:nil];
    }
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrlStr] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(loadImageWith:and:)]) {
                [weakSelf.delegate loadImageWith:ZXLoadImageStateFail and:nil];
            }
        }   else {
            if (finished) {
                [weakSelf updateImageViewWith:image];
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(loadImageWith:and:)]) {
                    [weakSelf.delegate loadImageWith:ZXLoadImageStateSuccess and:image];
                }
            }
        }
    }];
}

- (void)setImage:(UIImage *)image {
    [self updateImageViewWith:image];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadImageWith:and:)]) {
        [self.delegate loadImageWith:ZXLoadImageStateSuccess and:image];
    }
}

- (void)updateImageViewWith:(UIImage *)image {
    self.currentImage = image;
    self.imageView.image = image;
    CGSize imgSize = image.size;
    float imageScale = imgSize.width/imgSize.height;
    float h = SCREEN_WIDTH/imageScale;
    _imageViewHeight.constant = h;
    if (h>SCREEN_HEIGHT) {
        _scrollContentViewHeight.constant = h;
    }
}

- (void)singleTapHandle:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(singleTap)]) {
        [self.delegate singleTap];
    }
}

- (void)doubleTapHandle:(UITapGestureRecognizer *)tap {
    _imageViewHeight.constant = self.currentImage.size.height*1.2;
    _scrollContentViewHeight.constant = _imageViewHeight.constant;
}

- (void)panHandle:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        _startPoint = [pan locationInView:self];
    }   else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [pan locationInView:self];
        self.imageView.transform = CGAffineTransformMakeTranslation(0, (currentPoint.y-_startPoint.y)*1.1);
    }   else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint currentPoint = [pan locationInView:self];
        float offset = currentPoint.y-_startPoint.y;//移动距离
        if (fabsf(offset) > 50) {
            [UIView animateWithDuration:0.5 animations:^{
                if (offset>50) {
                    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, 500);
                }   else if (offset < -50) {
                    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, -500);
                }
            } completion:^(BOOL finished) {
                if ([self.delegate respondsToSelector:@selector(panGestureHandleDismiss)]) {
                    [self.delegate panGestureHandleDismiss];
                }
            }];
        }   else {
            self.imageView.transform = CGAffineTransformIdentity;
        }
    }
}

@end
