//
//  BackForwardItem.m
//  LightWebBrowser
//
//  Created by 明 on 13-2-28.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import "BackForwardItem.h"
#import "WebHistoryItem.h"
@implementation BackForwardItem
+(BackForwardItem*)fromWebHistoryItem:(id)item
{
    BackForwardItem* resutl = [[BackForwardItem alloc] init];
    resutl.title = [item title];
    resutl.url = [item performSelector:@selector(URLString)];
    resutl.scrollPoint = CGPointMake([[item performSelector:@selector(scrollPoint)] X], [[item performSelector:@selector(scrollPoint)] Y]) ;
    return resutl;
}

-(id)toWebHistoryItem{
    id item = [NSClassFromString(@"WebHistoryItem") entryWithURL:[NSURL URLWithString:self.url]];
    [item setTitle:self.title];
    [item _setScrollPoint:self.scrollPoint];
    return item;
}

//将对象编码(即:序列化)
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_url forKey:@"url"];
    [aCoder encodeCGPoint:_scrollPoint  forKey:@"scrollPoint"];
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.title =[aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.scrollPoint = [aDecoder decodeCGPointForKey:@"scrollPoint"];
    }
    return (self);
    
}


-(NSString*) description
{
    NSString *description = [NSString stringWithFormat:@"%@: %@",self.title,self.url ];
    return (description);
}
@end
