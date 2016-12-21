//
//  ViewController.m
//  GeocoderAndReverseReocoder
//
//  Created by Jn_Kindle on 2016/12/21.
//  Copyright © 2016年 JnKindle. All rights reserved.
//

#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地理编码
    [self geocoder];
    
    
    //地理反编码
    [self reverseGeocoder];
    
    
}


/**
 地理编码
 */
- (void)geocoder {
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    NSString *addressStr = @"广东省深圳市宝安区";//位置信息
    
    [geocoder geocodeAddressString:addressStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark=[placemarks firstObject];
        //经度
        NSString *longitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        //纬度
        NSString *latitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        
        
        NSLog(@"经度：%@，纬度：%@",longitude,latitude);
        
    }];
    
}



/**
 地理反编码
 */
- (void)reverseGeocoder{
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    //经度
    NSString *longitude = @"113.23";
    //纬度
    NSString *latitude = @"23.16";
    
    
    //创建位置
    CLLocation *location=[[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //详细地址
            NSString *addressStr = placemark.name;
            NSLog(@"详细地址1：%@",addressStr);
            NSLog(@"详细地址2：%@",placemark.addressDictionary);
            NSLog(@"详细地址3：%@",placemark.locality);
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    


}


@end
