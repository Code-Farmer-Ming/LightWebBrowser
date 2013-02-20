//
//  AutoCompleteView.h
//  LightWebBrowser
//
//  Created by 明 on 13-2-12.
//  Copyright (c) 2013年 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCompleteView : UIView<UITableViewDelegate, UITableViewDataSource>
    @property   (strong,nonatomic) NSArray *autocompleteUrls;
    @property   (weak,nonatomic)UITextField *inputField;

    - (id)init:(UITextField*) inputField;
@end
