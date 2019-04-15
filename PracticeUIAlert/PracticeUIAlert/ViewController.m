//
//  ViewController.m
//  PracticeUIAlert
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)showAlertVC:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancel
   otherButtonTitle:(NSString *)other
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:cancel
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    [alert addAction: cancelButton];
    
    if(other) {
        UIAlertAction *otherButton = [UIAlertAction
                                       actionWithTitle:other
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action) {
                                           (void) ^{
                                               NSLog(@"block");
                                           }();
                                           NSLog(@"%@", action.title);
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
        
        [alert addAction: otherButton];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showOKAlertVC:(NSString *)title message:(NSString *)message
{
    [self showAlertVC:title message:message cancelButtonTitle:@"확인" otherButtonTitle:nil];
}

- (void)showOKAlertVC:(NSString *)title message:(NSString *)message otherTitle:(NSString *)other
{
    [self showAlertVC:title message:message cancelButtonTitle:@"확인" otherButtonTitle:other];
}

- (IBAction)otherAction:(id)sender {
    [self showOKAlertVC:@"other" message:@"other" otherTitle:@"other"];
}

- (IBAction)cancelAction:(id)sender {
    [self showOKAlertVC:@"cancel" message:@"cancel"];
}
@end
