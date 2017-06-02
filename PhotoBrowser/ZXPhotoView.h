//
//  ZXPhotoView.h
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/24.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 加载图片的状态

 - ZXLoadImageStateStart: 开始加载
 - ZXLoadImageStateSuccess: 加载成功
 - ZXLoadImageStateFail: 加载失败
 */
typedef NS_ENUM(NSUInteger, ZXLoadImageState) {
    ZXLoadImageStateStart = 1,
    ZXLoadImageStateSuccess = 2,
    ZXLoadImageStateFail = 3
};

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@protocol ZXPhotoViewDelegate <NSObject>


/**
 加载图片回调

 @param state 家在状态
 @param image 加载成功时的image
 */
- (void)loadImageWith:(ZXLoadImageState)state and:(UIImage *)image;

/**
 单击隐藏
 */
- (void)singleTap;

- (void)panGestureHandleDismiss;

@end

@interface ZXPhotoView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;


/**
 图片地址
 */
@property (nonatomic, copy) NSString *imageUrlStr;

/**
 图片
 */
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) id <ZXPhotoViewDelegate> delegate;

@end
