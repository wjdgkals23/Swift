//
//  ViewController.h
//  PracticeUIAlert
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

typedef void (^AlertCompletionBlock)(NSInteger buttonIndex);
typedef void (^AlertActionCompletionBlock)(NSInteger buttonIndex);

@property (strong, nonatomic) AlertCompletionBlock callbackBlock;

- (void)showAlertVC:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancel
   otherButtonTitle:(NSString *)other;

- (void)showOKAlertVC:(NSString *)title message:(NSString *)message;
- (void)showOKAlertVC:(NSString *)title message:(NSString *)message otherTitle:(NSString *)other;

@end

