//
//  MainTabbarViewController.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "MainTabbarViewController.h"

static NSString *const OHA_ServiceVC = @"PhotoViewController";
static NSString *const OHA_communityVC = @"VideoViewController";
static NSString *const OHA_ShoppingCarViewVC = @"CentreViewController";

#define kClassKey @"rootVCClassString"
#define kTitleKey @"title"
#define kImageKey @"imageName"
#define kSelectimgKey @"selectedImageName"

static NSString *const OHA_Service = @"photo";
static NSString *const OHA_community = @"video";
static NSString *const OHA_ShoppingCar = @"my";
@interface MainTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *childItemsArray = @[
                                 @{kClassKey:OHA_ServiceVC,
                                   kTitleKey:OHA_Service,
                                   kImageKey:@"tabbar_mainframe",
                                   kSelectimgKey:@"tabbar_mainframeHL"},
                                @{kClassKey:OHA_communityVC,
                                    kTitleKey:OHA_community,
                                    kImageKey:@"tabbar_contacts",
                                    kSelectimgKey:@"tabbar_contactsHL"
                                    },
                                 @{kClassKey:OHA_ShoppingCarViewVC,
                                   kTitleKey:OHA_ShoppingCar,
                                   kImageKey:@"tabbar_shopingcar",
                                   kSelectimgKey:@"tabbar_shopingcarHL"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(obj[kClassKey])new];
        
        vc.title = obj[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = obj[kTitleKey];
        item.image = [UIImage imageNamed:obj[kImageKey]];
        item.selectedImage = [[UIImage imageNamed:obj[kSelectimgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
        if ([obj[kTitleKey] isEqualToString:OHA_ServiceVC]) {
            nav.navigationBar.translucent = YES;
        }
        [self addChildViewController:nav];
    }];
    self.selectedIndex = 0;
    self.delegate = self;
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    if ([viewController.title isEqualToString:@"购物车"]) {
    //        //创建一个消息对象
    //        NSNotification * notice = [NSNotification notificationWithName:@"ReloadTableView" object:nil userInfo:@{@"1":@"addInToCarReload"}];
    //        //发送消息
    //        [[NSNotificationCenter defaultCenter]postNotification:notice];
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
