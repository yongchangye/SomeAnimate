//
//  ViewController.m
//  SomeAnimate
//
//  Created by 叶永长 on 9/23/15.
//  Copyright © 2015 YYC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    UIView *LayerView;
    
    UILabel *LayerLabel;
    
    UITextField *ShakeTextField;
    
    
    UIView *DompView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, [UIScreen mainScreen].bounds.size.height-50, 100, 30);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    
    LayerView = [[UIView alloc]initWithFrame:CGRectMake(20, 80, 30, 30)];
    LayerView.backgroundColor =[ UIColor redColor];
    LayerView.layer.cornerRadius = 5;
    LayerView.layer.masksToBounds =YES;
    [self.view addSubview:LayerView];
    
    
    LayerLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 80, 100, 30)];
    LayerLabel.text = @"LayerLabel";
    LayerLabel.layer.cornerRadius = 5;
    LayerLabel.layer.masksToBounds = YES;
    LayerLabel.textAlignment = NSTextAlignmentCenter;
    LayerLabel.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:1];
    LayerLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:LayerLabel];
    
    
    
    ShakeTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, 150, 30)];
    ShakeTextField.layer.cornerRadius = 5;
    ShakeTextField.layer.masksToBounds = YES;
    ShakeTextField.layer.borderWidth = 0.5;
    ShakeTextField.layer.borderColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:1].CGColor;
    [self.view addSubview:ShakeTextField];
    
    
    
    DompView = [[UIView alloc]initWithFrame:CGRectMake(20, 180, 30, 30)];
    DompView.backgroundColor = [UIColor redColor];
    DompView.layer.cornerRadius = 5;
    DompView.layer.masksToBounds = YES;
    [self.view addSubview:DompView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [ShakeTextField resignFirstResponder];
}
-(void)btnClick:(UIButton *)sender{
    
    //放大并且消失
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1.0)]];
    [UIView animateWithDuration:1 animations:^{
        LayerView.alpha = 0;
    } completion:^(BOOL finished) {
        LayerView.alpha = 1;
    }];
    animation.values = values;
    [LayerView.layer addAnimation:animation forKey:nil];
    
    
    //文字倾斜消失
    [UIView animateWithDuration:1 animations:^{
        LayerLabel.transform = CGAffineTransformMakeScale(1.0, 0.5);
        LayerLabel.alpha = 0;
    } completion:^(BOOL finished) {
        LayerLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        LayerLabel.alpha = 1;
    }];

    
    
    //抖动
    ShakeTextField.layer.borderColor = [UIColor redColor].CGColor;
    [self shakeView:ShakeTextField];
    
    
    //阻尼
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        DompView.frame = CGRectMake(20, 250, 30, 30);
        
    } completion:^(BOOL finished) {
        DompView.frame = CGRectMake(20, 180, 30, 30);
    }];
}


-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
