//
//  DrawView.m
//  画板test
//
//  Created by  John on 16/7/13.
//  Copyright © 2016年  John. All rights reserved.
//

#import "DrawView.h"
#import "HMBezierPath.h"

@interface DrawView ()

@property(nonatomic,strong)NSMutableArray *paths ;

@end

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //渲染数组内的所有路径
    for (HMBezierPath *path in _paths) {
        
        [path.lineColorX set] ;
        [path stroke] ;
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext() ;
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
    NSString *filePath = [docPath stringByAppendingString:@"draw.png"] ;
    NSData *data = UIImagePNGRepresentation(image) ;
    [data writeToFile:filePath atomically:YES] ;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!self.paths) {
        self.paths = [NSMutableArray array] ;
    }

    // 获取触摸对象
    UITouch *t = [touches anyObject] ;
    // 获取手指的位置
    CGPoint p = [t locationInView:t.view] ;
    // 创建路径
    HMBezierPath *path = [HMBezierPath bezierPath] ;

    // 设置样式
    [path setLineColorX:self.lineColor] ;
    [path setLineWidth:self.lineWidth ?: 5] ;
    
    [path setLineCapStyle:kCGLineCapRound] ;
    [path setLineJoinStyle:kCGLineJoinRound] ;
    
    
    //设置起点
    [path moveToPoint:p] ;
    
    //将多条路径保存进数组
    [self.paths addObject:path] ;

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //获取点击事件
    UITouch *t = [touches anyObject] ;
    //获取点击位置
    CGPoint p = [t locationInView:t.view] ;

    //从数组中获取最后一条路径的起始位置并连接
    [[self.paths lastObject] addLineToPoint:p] ;

    [self setNeedsDisplay] ;
}




@end
