//
//  AppDelegate.m
//  NativeDemo
//
//  Created by H on 2019/7/12.
//  Copyright © 2019 LogicEDU. All rights reserved.
//

#import "AppDelegate.h"
#import <Flutter/Flutter.h>

@interface AppDelegate ()
/**  */
@property (nonatomic, strong) FlutterMethodChannel * methodChannel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  FlutterViewController *vc = [[FlutterViewController alloc] init];
    self.window.rootViewController = vc;
    
    //显示相册
    self.methodChannel =  [FlutterMethodChannel methodChannelWithName:@"mine_page/method" binaryMessenger:vc];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;

    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"picture"]) {

            [vc presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    return YES;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString * imageUrl = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        
        [self.methodChannel invokeMethod:@"image" arguments:imageUrl];
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
