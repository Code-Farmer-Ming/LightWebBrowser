//
//  GoButton.h
//  LightWebBrowser
//
//  Created by 明 on 13-1-25.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GoButtonType) {
    GoBtuttonTypeGo,
    GoBtuttonTypeSeach,
    GoBtuttonTypeReload,
    GoBtuttonTypeStop,
};
@interface GoButton : UIButton
    @property GoButtonType  currentType;
    @property (strong, nonatomic)  UIImage*  goImage ;
    @property (strong, nonatomic)  UIImage*  seachImage ;
    @property (strong, nonatomic)  UIImage*  reloadImage ;
    @property (strong, nonatomic)  UIImage*  stopImage ;
@end
