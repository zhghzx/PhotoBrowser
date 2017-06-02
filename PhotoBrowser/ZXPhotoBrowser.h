//
//  ZXPhotoBrowser.h
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/18.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXPhotoBrowser : UIViewController


/**
 图片数组,支持image,urlStr.dataSource个数为1时隐藏顶部指示
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 打开特定图片对应下标,不设置则从第一张开始
 */
@property (nonatomic, assign) NSInteger index;



@end
