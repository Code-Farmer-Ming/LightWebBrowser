//
//  CustomToolbar.m
//  LightWebBrowser
//
//  Created by 明 on 12-12-28.
//  Copyright (c) 2012年 明. All rights reserved.
//

#import "CustomToolbar.h"

@implementation CustomToolbar

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context    =  UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 0.6);
    
    
    CGContextMoveToPoint(context,0,rect.size.height); //start at this point
    
    CGContextAddLineToPoint(context, rect.size.width,rect.size.height); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);

}
@end
