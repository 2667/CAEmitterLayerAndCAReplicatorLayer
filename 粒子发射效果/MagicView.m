//
//  MagicView.m
//  forBirthDay
//
//  Created by 辛为舟 on 16/9/20.
//  Copyright © 2016年 myHeart. All rights reserved.
//

#import "MagicView.h"

@interface MagicView()
@property(nonatomic,strong) UIBezierPath *path;
@property(nonatomic,weak) CALayer *dotLayer ;
@property(nonatomic,assign) long int pointsNum;

@end

@implementation MagicView

// 改变本图层类型
+ (nonnull Class)layerClass {
    return [CAReplicatorLayer  class];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    
    //创建粒子
    CALayer *dotLayer = [CALayer layer];
    dotLayer.frame = CGRectMake(-10, 0, 10, 10);
    dotLayer.contents = (id)[UIImage imageNamed:@"heart-icons-0.png"].CGImage;
    self.dotLayer = dotLayer;
    [self.layer addSublayer:dotLayer];
    // 颜色透明
//    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

//开始
- (void)start {

    //取出复制图层
    CAReplicatorLayer *repL =  (CAReplicatorLayer *)self.layer;
    repL.instanceCount = self.pointsNum/2.5;
    repL.instanceDelay = 0.35;
    //添加动画.
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.duration = repL.instanceCount * repL.instanceDelay;
    [self.dotLayer addAnimation:anim forKey:nil];
    
    
    //把路径清空
    [self.path removeAllPoints];
    NSLog(@"%f,",self.path.flatness);
    
    self.pointsNum = 0;
    
    [self setNeedsDisplay];
}

//重绘
- (void)reDraw {

    self.pointsNum = 0;
    //把路径清空
    [self.path removeAllPoints];
    [self setNeedsDisplay];
    
    //移除动画
    [self.dotLayer removeAllAnimations];
}

// 手势Action
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //获取手指当前的点
    CGPoint curP = [pan locationInView:self];
    if(pan.state == UIGestureRecognizerStateBegan){
            self.pointsNum++;
            [self.path moveToPoint:curP];
        
        } else if(pan.state == UIGestureRecognizerStateChanged) {
            self.pointsNum++;
            [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }

}

// 默认Touch事件继续传递
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置线的宽度
    CGContextSetLineWidth(ctx, 20);
    //设置线的连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //设置顶角的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //设置线的颜色
    [[UIColor orangeColor] setStroke];
    [self.path setLineWidth:10];
    [self.path setLineCapStyle:kCGLineCapRound];
    [self.path setLineJoinStyle:kCGLineJoinRound];
    [self.path stroke];
}

@end
