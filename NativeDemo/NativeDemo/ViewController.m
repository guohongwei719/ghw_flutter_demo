//
//  ViewController.m
//  NativeDemo
//
//  Created by H on 2019/7/12.
//  Copyright © 2019 LogicEDU. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()
/**  */
@property (nonatomic, strong) FlutterViewController  * vc;
/**  */
@property (nonatomic, strong) FlutterBasicMessageChannel *massageChannel ;
@end

@implementation ViewController

- (IBAction)pushFlutterTow:(id)sender {
     //显示第二个页面
       FlutterMethodChannel * methodChannel =  [FlutterMethodChannel methodChannelWithName:@"tow_page" binaryMessenger:self.vc];
    [self presentViewController:self.vc animated:YES completion:nil];
    //监听退出
    [methodChannel invokeMethod:@"tow" arguments:nil];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.vc dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    
}


- (IBAction)pushFlutter:(id)sender {
    //显示第一个页面
    FlutterMethodChannel * methodChannel =  [FlutterMethodChannel methodChannelWithName:@"one_page" binaryMessenger:self.vc];
    [methodChannel invokeMethod:@"one" arguments:nil];
     [self presentViewController:self.vc animated:YES completion:nil];
    //监听退出
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.vc dismissViewControllerAnimated:NO completion:nil];
        }
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vc = [[FlutterViewController alloc] init];
    [self.vc setInitialRoute:@"one"];
    
    //监听MessageChannel的数据
    self.massageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"messageChannel" binaryMessenger:self.vc];
    [self.massageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"%@",message);
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int a = 0;
    [self.massageChannel sendMessage:[NSString stringWithFormat:@"%d",a++]];
}


@end
