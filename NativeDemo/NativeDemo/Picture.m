//
//  Picture.m
//  NativeDemo
//
//  Created by H on 2019/7/18.
//  Copyright © 2019 LogicEDU. All rights reserved.
//

#import "Picture.h"

@interface Picture()

@end

@implementation Picture

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",info);
    }];
}

@end
