//
//  ViewController.h
//  DataSourceExample
//
//  Created by 정하민 on 09/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate> {
    NSArray *companyName;
    NSArray *tesla;
    NSArray *teslaImg;
    NSArray *lamborghini;
    NSArray *lamborghiniImg;
    NSArray *porsche;
    NSArray *porscheImg;
    NSArray *nameSet;
    NSArray *imgSet;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

