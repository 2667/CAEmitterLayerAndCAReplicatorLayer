//
//  ViewController.m
//  粒子发射效果
//
//  Created by XinWeizhou on 2017/5/5.
//  Copyright © 2017年 XinWeizhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) CAEmitterLayer *emitter;
@property(nonatomic,strong) CAEmitterCell *cell0;
@property(nonatomic,strong) CAEmitterCell *cell1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor=[UIColor blueColor];
    //设置发射器
    self.emitter = [[CAEmitterLayer alloc]init];
    self.emitter.emitterPosition = CGPointMake(self.view.frame.size.width/2 ,self.view.frame.size.height * 0.5);
//    self.emitter.emitterSize =  CGSizeMake(self.view.frame.size.width - 100, 20);
    self.emitter.emitterSize =  CGSizeMake(200, 200);
    self.emitter.emitterShape = kCAEmitterLayerLine;
    
    self.emitter.emitterMode = kCAEmitterLayerPoints;
    self.emitter.renderMode = kCAEmitterLayerOldestLast;
    self.emitter.backgroundColor = [UIColor redColor].CGColor;
//    self.emitter.preservesDepth = YES;
//    self.emitter.emitterDepth = 100;
    
    //发射单元0
    CAEmitterCell * cell0 = [CAEmitterCell emitterCell];
    self.cell0 = cell0;
    cell0.birthRate = 50;
    cell0.lifetime = 5.0;
    cell0.lifetimeRange = 1.5;
//    cell0.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    cell0.contents = (id)[[UIImage imageNamed:@"heart-icons-0.png"]CGImage];
    cell0.contentsScale = 5;
    [cell0 setName:@"cell0"];
    
    cell0.velocity = 100;
    cell0.velocityRange = 0;
//    cell0.emissionLatitude = M_PI_4;
    cell0.emissionLongitude = M_PI_4;
    cell0.emissionRange = 0;
    cell0.scale = 0.5;
    cell0.scaleSpeed = 1.2;
    cell0.spin = 0;
    
    //发射单元1
    CAEmitterCell *cell1 = [CAEmitterCell emitterCell];
    self.cell1 = cell1;
    cell1.birthRate = 50;
    cell1.lifetime = 5.0;
    cell1.lifetimeRange = 1.5;
    //    cell0.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    cell1.contents = (id)[[UIImage imageNamed:@"heart-icons-8"]CGImage];
    cell1.contentsScale = 5;
    [cell1 setName:@"cell1"];
    
    cell1.velocity = 200;
    cell1.velocityRange = 0;
    //    cell0.emissionLatitude = M_PI_4;
    cell1.emissionLongitude = - M_PI_4;
    cell1.emissionRange = 0;
    cell1.scale = 0.5;
    cell1.scaleSpeed = 1.2;
    cell1.spin = 0;
    
    self.emitter.emitterCells = @[cell0];
    self.emitter.seed = 50;
    [self.view.layer addSublayer:self.emitter];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (arc4random_uniform(4)) {
        case 0:
            self.emitter.emitterCells = @[self.cell0];
            break;
        case 1:
            self.emitter.emitterCells = @[self.cell1];
            break;
          
        case 2:
            self.emitter.emitterCells = @[self.cell1,self.cell0];
            break;
            
        default:
            self.emitter.emitterCells = @[self.cell0,self.cell1];
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
