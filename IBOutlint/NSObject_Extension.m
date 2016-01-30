//
//  NSObject_Extension.m
//  IBOutlint
//
//  Created by Marcelo Fabri on 28/01/16.
//  Copyright © 2016 Marcelo Fabri. All rights reserved.
//


#import "NSObject_Extension.h"
#import "IBOutlint.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin {
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[IBOutlint alloc] initWithBundle:plugin];
        });
    }
}

@end
