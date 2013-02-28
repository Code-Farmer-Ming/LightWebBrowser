//
//  WrapBackForwardList.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-28.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "WrapBackForwardList.h"

@implementation WrapBackForwardList
//将对象编码(即:序列化)
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.currentItemIndex forKey:@"currentItemIndex"];
    
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.currentItemIndex =[aDecoder decodeIntForKey:@"currentItemIndex"];
       
    }
    return (self);
    
}
@end
