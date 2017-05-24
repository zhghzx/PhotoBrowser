//
//  ZXPhotoView.h
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/24.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXPhotoViewDelegate <NSObject>

- (void)singleTap;

@end

@interface ZXPhotoView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeight;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (nonatomic, copy) NSString *imageUrlStr;

@property (nonatomic, weak) id <ZXPhotoViewDelegate> delegate;

@end
