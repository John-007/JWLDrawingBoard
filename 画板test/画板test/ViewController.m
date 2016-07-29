//
//  ViewController.m
//  画板test
//
//  Created by  John on 16/7/13.
//  Copyright © 2016年  John. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (weak, nonatomic) IBOutlet UISlider *sliderValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.sliderValue addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged] ;
    
}

-(void)sliderChange:(UISlider *)sender{

    self.drawView.lineWidth = sender.value ;

}

- (IBAction)didSave:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0) ;
    [self.drawView drawViewHierarchyInRect:self.drawView.bounds afterScreenUpdates:YES];
    
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 保存相册 - 完成的是有一定要使用系统的方法
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"123123123");
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSLog(@"保存成功");
    
    NSLog(@"%@", contextInfo);
}

- (IBAction)setColor:(UIButton*)sender {
    
    self.drawView.lineColor = sender.backgroundColor ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
