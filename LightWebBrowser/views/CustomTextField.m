//
//  CustomTextField.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-11.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField


- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
   
        // Initialization code
        [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd ];

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
-(void)editEnd
{
//    self.text = self.title;
}


@end
