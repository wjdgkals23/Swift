//
//  ViewController.m
//  DataSourceExample
//
//  Created by 정하민 on 09/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *objPicker = [UIPickerView new];
    objPicker.delegate = self;
    objPicker.dataSource = self;
    objPicker.showsSelectionIndicator = YES;
    
    imgSet = [[NSArray alloc] init];
    nameSet = [[NSArray alloc] init];
    companyName = [[NSArray alloc]initWithObjects:@"테슬라",@"람보르기니", nil];
    
    tesla = [[NSArray alloc]initWithObjects:@"모델s",@"모델x", nil];
    teslaImg = [[NSArray alloc]initWithObjects:@"tesla-model-s.jpg",@"tesla-model-x.jpg", nil];
    lamborghini = [[NSArray alloc]initWithObjects:@"aventador",@"huracan",@"veneno", nil];
    lamborghiniImg = [[NSArray alloc]initWithObjects:@"lamborghini-aventador.jpg",@"lamborghini-huracan.jpg",@"lamborghini-veneno.jpg", nil];
    
    imgSet = teslaImg;
    nameSet = tesla;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return companyName.count;
    } else {
        return nameSet.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0){
        return companyName[row];
    }else {
        return nameSet[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0) {
        if(row == 0) {
            imgSet = teslaImg;
            nameSet = tesla;
        } else {
            imgSet = lamborghiniImg;
            nameSet = lamborghini;
        }
        pickerView.reloadAllComponents;
        [imgView setImage:[UIImage imageNamed:imgSet[[pickerView selectedRowInComponent:1]]]];
    } else {
        [imgView setImage:[UIImage imageNamed:imgSet[row]]];
    }
}


@end
