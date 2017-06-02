
#import <UIKit/UIKit.h>

@interface UIView (ZXExt)

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat w;
@property(nonatomic,assign)CGFloat h;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat bottom;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;

@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;
@end
