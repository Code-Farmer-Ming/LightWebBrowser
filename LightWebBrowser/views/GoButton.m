//
//  GoButton.m
//  LightWebBrowser
//
//  Created by 明 on 13-1-25.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "GoButton.h"

@implementation GoButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

-(void) setType
{
    self.imageView.image =  self.goImage;
}

@end
