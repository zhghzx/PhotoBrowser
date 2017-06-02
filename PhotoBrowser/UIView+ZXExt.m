
#import "UIView+ZXExt.h"

@implementation UIView (ZXExt)

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)w{
    return self.frame.size.width;
}

-(void)setW:(CGFloat)w{
    CGRect frame=self.frame;
    frame.size.width=w;
    self.frame=frame;
}

-(CGFloat)h{
    return self.frame.size.height;
}

-(void)setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame.size.height=h;
    self.frame=frame;
}
- (CGFloat)right
{
    return self.x + self.w;
}
- (void)setRight:(CGFloat)right
{
    CGRect frame=self.frame;
    frame.origin.x=right - self.w;
    self.frame=frame;
}

- (CGFloat)bottom
{
    return self.y + self.h;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame=self.frame;
    frame.origin.y=bottom - self.h;
    self.frame=frame;
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    self.frame = frame;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius>0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}


@end
