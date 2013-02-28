//
//  GoButton.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-25.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "GoButton.h"
@interface GoButton()

    @property (strong, nonatomic)  UIImage*  goImage ;
    @property (strong, nonatomic)  UIImage*  seachImage ;
    @property (strong, nonatomic)  UIImage*  reloadImage ;
    @property (strong, nonatomic)  UIImage*  stopImage ;
@end

@implementation GoButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        // Initialization code
        self.goImage =  [UIImage imageNamed:@"go.png"];
        self.seachImage =  [UIImage imageNamed:@"search.png"];
        self.reloadImage =  [UIImage imageNamed:@"reload.png"];
        self.stopImage =  [UIImage imageNamed:@"stop.png"];
        self.currentType = GoBtuttonTypeGo;
       
   
    }
    return self;
}

-(id) init{
    if(self = [super init]) {
        // Initialization code
        self.goImage =  [UIImage imageNamed:@"go.png"];
        self.seachImage =  [UIImage imageNamed:@"search.png"];
        self.reloadImage =  [UIImage imageNamed:@"reload.png"];
        self.stopImage =  [UIImage imageNamed:@"stop.png"];
        self.currentType = GoBtuttonTypeGo;
        
        
    }
    return self;
}
 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setCurrentType:(GoButtonType)value
{
     _currentType =  value;
    [self updateImg];
}

-(void) updateImg
{
    UIImage *img;
    switch (self.currentType)
    {
        case GoBtuttonTypeReload:
            img = self.reloadImage;
            break;
        case GoBtuttonTypeSeach:
            img = self.seachImage;
            break;
        case GoBtuttonTypeStop:
            img = self.stopImage;
            break;
        default:
            img = self.goImage;
            break;
    };
    [self setImage:img forState:UIControlStateNormal];
}

@end
