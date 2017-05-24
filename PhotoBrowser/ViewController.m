//
//  ViewController.m
//  PhotoBrowser
//
//  Created by zhangxing on 2017/5/18.
//  Copyright © 2017年 zhangxing. All rights reserved.
//

#import "ViewController.h"
#import "ZXPhotoBrowser.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bt:(UIButton *)sender {
    ZXPhotoBrowser *browser = [[ZXPhotoBrowser alloc] init];
    browser.dataSource = self.dataource;
    if (sender.tag) {
        browser.index = 3;
    }
    browser.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:browser animated:YES completion:nil];
}

- (NSArray *)dataource {
    if (_dataource == nil) {
        _dataource = [NSArray arrayWithObjects:@"https://image.artplanet.cn/article/50fbc311-86f8-488b-967b-d5159638a591.jpg", @"https://image.artplanet.cn/article/cab13904-88b6-4a49-b2b2-9642c1e25908.jpg", @"https://image.artplanet.cn/article/6caa6a0d-757b-431e-9c5c-5b614641c115.jpg", @"https://image.artplanet.cn/article/1142c0af-2b89-4eec-b652-6591cf13084e.jpg", @"https://image.artplanet.cn/article/bc717e7f-e808-4499-a46f-c0555f831c4f.jpg", @"https://image.artplanet.cn/article/fe8ea882-ebbc-4e45-bd4e-8b6dfd94be01.jpg", @"https://image.artplanet.cn/article/a58e0cd2-098e-44b1-94cd-e8ea56a9380a.jpg", @"https://image.artplanet.cn/article/78584d37-c2c8-4bfa-97a0-f70a408228b1.jpg", @"https://image.artplanet.cn/article/067e93b7-8808-48b8-a20a-6d27d185c170.jpg", @"https://image.artplanet.cn/article/37bbd51a-92b8-437e-acd0-18efc29cfc32.jpg", @"https://image.artplanet.cn/article/349998a9-38f2-4a2a-a1fe-358d013e244b.jpg", @"https://image.artplanet.cn/article/28f96c8a-8810-4dc3-906f-e8f52111816e.jpg", nil];
    }
    return _dataource;
}

@end
